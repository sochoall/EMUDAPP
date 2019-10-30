import 'dart:async';
import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:app_movil/transportista/tabs/rutas.dart';

Future<List<Post>> fetchPost() async
{
  var response = await http.get("http://192.168.137.1:8888/parada/1");

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
  String latitud;
  String longitud;

  Post(
    {
      this.latitud,
      this.longitud,
    }
  );

  factory Post.fromJson(Map<String, dynamic> json)
  {
    return Post(
      latitud: json['latitud'],
      longitud: json['longitud'],
    );
  }
}

class MyApp extends StatelessWidget 
{
  final String aux; 
  MyApp(this.aux);
  
  @override
  Widget build(BuildContext context) 
  {
    return new MaterialApp(
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget 
{
  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> 
{
  bool flag=false;
  Future<Post> post;
  Position userLocation;
  List<LatLng> points = [];
  Geolocator geolocator = Geolocator();

  @override
  Widget build(BuildContext context) 
  {
    getUserCoords();
    return new Scaffold(
      body: userLocation == null ? 
      Center(
        child: CircularProgressIndicator()
      )
      :
      Center(
        child: FutureBuilder<List<Post>>(
          future: fetchPost(),
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              flag == false ? snapshot.data.map((post) => buildStopMarkers(post.latitud, post.longitud)).toList() : getUserProximity();
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
      setState(() 
      {
        userLocation = value; 
      });
    });
    return userLocation;
  }

  void getUserProximity()
  {
    double posX, posY, negX, negY;
    
    if(points.isNotEmpty)
    {
      posX=points.first.latitude+0.000020;
      posY=points.first.longitude+0.000020;
      negX=points.first.latitude-0.000020;
      negY=points.first.longitude-0.000020;

      if(userLocation.latitude>posX && userLocation.longitude>posY)
      {
        removeStopMarkers(points.first);
        RutasEstado.names.removeAt(0);
      }
      else if(userLocation.latitude>negX && userLocation.longitude>posY)
      {
        removeStopMarkers(points.first);
        RutasEstado.names.removeAt(0);
      }
      else if(userLocation.latitude>negX && userLocation.longitude>negY)
      {
        removeStopMarkers(points.first);
        RutasEstado.names.removeAt(0);
      }
      else if(userLocation.latitude>posX && userLocation.longitude>negY)
      {
        removeStopMarkers(points.first);
        RutasEstado.names.removeAt(0);        
      }
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
            icon: Icon(Icons.location_on),
            color: Colors.red,
            iconSize: 45.0,
            onPressed:()
            {
              removeStopMarkers(latlng);
              //RutasEstado.removeName();
            },
          ),
        ),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      );
    }).toList();

    return FlutterMap(
      options: MapOptions(
        center: LatLng(-2.901866, -79.006055),
        maxZoom: 19.0, 
        minZoom: 12,
        zoom: 13,
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
    return new MarkerLayerOptions(markers: [
      new Marker(
        width: 45.0,
        height: 45.0,
        point: LatLng(userLocation.latitude, userLocation.longitude),
        builder: (context) => new Container(
          child: IconButton(
            icon: Icon(Icons.navigation),
            color: Colors.lightBlue,
            iconSize: 35.0,
            onPressed: ()
            {
              
            },
          ),
        )
      )
    ]);
  }

  void buildStopMarkers(String latitud, String longitud)
  {
    LatLng latlng = new LatLng(double.parse(latitud), double.parse(longitud));
    points.add(latlng);
  }

  void removeStopMarkers(LatLng latlng)
  {
    points.removeWhere((item) => (item.latitude == latlng.latitude) & (item.longitude == latlng.longitude));
  }
}