import 'dart:async';
import 'dart:convert';
import 'package:app_movil/transportista/tabs/rutas.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';

Future<List<Post>> fetchPost(id) async
{
  var response = await http.get("http://192.168.137.1:8888/parada/$id");

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

//void main() => runApp(new MyApp());

class MyApp extends StatelessWidget 
{
  String idRecorrido;
  MyApp(this.idRecorrido);
  @override
  Widget build(BuildContext context) 
  {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(idRecorrido),
    );
  }
}

class MyHomePage extends StatefulWidget 
{
   String idRecorrido;

  MyHomePage(this.idRecorrido);



  @override
  _MyHomePageState createState() => new _MyHomePageState(idRecorrido);
}

class _MyHomePageState extends State<MyHomePage> 
{
  String idRecorrido;

  _MyHomePageState(this.idRecorrido);

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
          future: fetchPost(idRecorrido),
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

  getUserCoords()
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

  getUserProximity()
  {
    double posX, posY, negX, negY;
    
    posX=points.first.latitude+0.000020;
    posY=points.first.longitude+0.000020;
    negX=points.first.latitude-0.000020;
    negY=points.first.longitude-0.000020;

    if(userLocation.latitude>posX && userLocation.longitude>posY)
    {
      removeStopMarkers(points.first);
     //removeLastItem();
      
    }
       
    else if(userLocation.latitude>negX && userLocation.longitude>posY)
    {
        removeStopMarkers(points.first);
        //removeLastItem();
    }
      
    else if(userLocation.latitude>negX && userLocation.longitude>negY)
    {
      removeStopMarkers(points.first);
      //removeLastItem();
    }
      
    else if(userLocation.latitude>posX && userLocation.longitude>negY)
    {
      removeStopMarkers(points.first);
     // removeLastItem();
    }
      
  }

  buildMap()
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
            onPressed: ()
            {
              removeStopMarkers(latlng);
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

  buildUserMarkLocation()
  {
    return new MarkerLayerOptions(markers: [
      new Marker(
        width: 45.0,
        height: 45.0,
        point: LatLng(userLocation.latitude, userLocation.longitude),
        builder: (context) => new Container(
          child: IconButton(
            icon: Icon(Icons.navigation
            ),
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

  buildStopMarkers(String latitud, String longitud)
  {
    LatLng latlng = new LatLng(double.parse(latitud), double.parse(longitud));
    points.add(latlng);
  }

  removeStopMarkers(LatLng latlng)
  {
    points.removeWhere((item) => (item.latitude == latlng.latitude) & (item.longitude == latlng.longitude));
  }
}