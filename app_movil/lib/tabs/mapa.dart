import 'dart:async';
import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';

Future<List<Post>> fetchPost() async
{
  var response = await http.get("http://10.10.12.51:8888/parada/1");

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

class MapPage extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return new MaterialApp(
      title: 'Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Fultter Geolocation'),
    );
  }
}

class MyHomePage extends StatefulWidget 
{
  MyHomePage({this.title});
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  Future<Post> post;
  Position userLocation;
  List<LatLng> points = [];
  Geolocator geolocator = Geolocator();

  @override
  Widget build(BuildContext context) 
  {
    getUserCoords();
    return new Scaffold(
      appBar: new AppBar(title: new Text('Leaflet Maps')),
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
              snapshot.data.map((post) => buildStopMarkers(post.latitud, post.longitud)).toList();
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
}