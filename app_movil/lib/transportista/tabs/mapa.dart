import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:app_movil/transportista/tabs/rutas.dart';

Future<List<Post>> fetchPost(idR) async
{ 
  var response = await http.get("http://192.168.137.1:8888/parada/$idR");

  if(response.statusCode == 200)
  {
    final jsonresponse = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Post> listOfCoords = jsonresponse.map<Post>((json)
    {
      return Post.fromJson(json);
    }).toList();

    return listOfCoords;
  }  
  else
    throw Exception('Failed to get items');
}

class Post
{
  int id;
  String latitud;
  String longitud;

  Post(
    {
      this.id,
      this.latitud,
      this.longitud,
    }
  );

  factory Post.fromJson(Map<String, dynamic> json)
  {
    return Post(
      id: json['id'],
      latitud: json['latitud'],
      longitud: json['longitud'],
    );
  }
}

class MyApp extends StatelessWidget 
{
  final String idR; 
  MyApp(this.idR);
  
  @override
  Widget build(BuildContext context) 
  {
    return new MaterialApp(
      home: new MyHomePage(idR),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget 
{
  final String idR; 
  MyHomePage(this.idR);
  @override
  MyHomePageState createState() => new MyHomePageState(idR);
}

class MyHomePageState extends State<MyHomePage> 
{
  final String idR; 
  Future<Post> post;
  Position userLocation;
  static List<int> ids = [];
  MyHomePageState(this.idR);
  static List<LatLng> points = [];
  bool flag=false, statusFlag=false;
  Geolocator geolocator = Geolocator();

  @override
  Widget build(BuildContext context) 
  {
    getUserCoords();
    return Scaffold(
      body: userLocation == null ? 
      Center(
        child: CircularProgressIndicator()
      )
      :
      Center(
        child: FutureBuilder<List<Post>>(
          future: fetchPost(idR),
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              flag == false && points.isEmpty ? snapshot.data.map((post) => buildStopMarkers(post.id, post.latitud, post.longitud)).toList() : getUserProximity();
              flag = true;
            }
            else if (snapshot.hasError)
              return Text("No hay paradas cargadas");
            return buildMap();
          }
        )
      )
    );
  }
  
  _getCurrentPosition()
  {
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, timeInterval: 3000);
    var positionStream;

    positionStream = geolocator.getPositionStream(locationOptions);
        
    return positionStream;
  }

  Position getUserCoords()
  {
    _getCurrentPosition().listen((value)
    {
      if(mounted)
      {
        setState(() 
        {
          userLocation = value;
        });
      }
    });
    return userLocation;
  }

  void getUserProximity()
  {
    double xPos, yPos, xNeg, yNeg, rad = 0.000300;
    
    if(points.isNotEmpty)
    {
      xPos=points.first.latitude+rad;
      yPos=points.first.longitude+rad;
      xNeg=points.first.latitude-rad;
      yNeg=points.first.longitude-rad;

      if((userLocation.latitude<xPos && userLocation.longitude<yPos) && (userLocation.latitude>points.first.latitude && userLocation.longitude>points.first.longitude))
        statusFlag=true;
      else if((userLocation.latitude>xNeg && userLocation.longitude<yPos) && (userLocation.latitude<points.first.latitude && userLocation.longitude>points.first.longitude))
        statusFlag=true;
      else if((userLocation.latitude>xNeg && userLocation.longitude>yNeg) && (userLocation.latitude<points.first.latitude && userLocation.longitude<points.first.longitude))
        statusFlag=true;
      else if((userLocation.latitude<xPos && userLocation.longitude>yNeg) && (userLocation.latitude>points.first.latitude && userLocation.longitude<points.first.longitude)) 
        statusFlag=true;
      else
        getFlagStatus();
    }
  }

  void getFlagStatus()
  {
    if(statusFlag)
    {
      removeStopMarkers(points.first);
      RutasEstado.names.removeAt(0);
      statusFlag=false;
    }
  }

  FlutterMap buildMap()
  {
    var stopMarkers = points.map((latlng)
    {
      return Marker(
        width: 45.0,
        height: 45.0,
        point: latlng,
        builder: (ctx) => Container(
          child: IconButton(
            icon: Icon(Icons.airport_shuttle),
            color: Colors.red,
            iconSize: 45.0,
            onPressed:()
            {
            },
          ),
        ),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      );
    }).toList();

    return FlutterMap(
      options: MapOptions(
        center: LatLng(userLocation.latitude, userLocation.longitude),
        maxZoom: 19.0, 
        minZoom: 12,
        zoom: 17,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:"https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']
        ),
        buildUserMarkLocation(),
        MarkerLayerOptions(markers: stopMarkers)
      ],
    );
  }

  MarkerLayerOptions buildUserMarkLocation()
  {
    return MarkerLayerOptions(markers: [
      new Marker(
        width: 45.0,
        height: 45.0,
        point: LatLng(userLocation.latitude, userLocation.longitude),
        builder: (context) => new Container(
          child: IconButton(
            icon: Icon(Icons.my_location),
            color: Colors.lightBlue,
            iconSize: 35.0,
            onPressed: ()
            {
              
            },
          ),
        ),
        anchorPos: AnchorPos.align(AnchorAlign.center),
      )
    ]);
  }

  void buildStopMarkers(int id, String latitud, String longitud)
  {
    LatLng latlng = new LatLng(double.parse(latitud), double.parse(longitud));
    points.add(latlng);
    ids.add(id);
  }

  void removeStopMarkers(LatLng latlng)
  {
    sendRecord(points.elementAt(0));
    points.removeAt(0);
    ids.removeAt(0);
  }

  void sendRecord(LatLng latlng) async 
  {
    try 
    {
      var url = "http://192.168.137.1:8888/monitoreo";

      Map<String, String> headers = {"Content-Type": "application/json"};
      String json = "";
      json ='{"mon_id": "0", "mon_fecha_hora": "${DateTime.now()}", "mon_completo": "0", "mon_latitud": "${latlng.latitude}", "mon_longitud": "${latlng.longitude}", "tmo_id":"1", "tpa_id":"1", "par_id":"1", "rec_id":"$idR"}';
      Response response =await http.post(url, headers: headers, body: json);
      int statusCode = response.statusCode;
      print(statusCode);
      print("Guardado con éxito.");
    } 
    catch (e) 
    {
      print(e.toString());
    }
  }
}