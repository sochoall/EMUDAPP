import 'dart:async';
import 'dart:convert';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:app_movil/transportista/tabs/rutas.dart';

Future<List<Post>> fetchPost(idR) async
{ 
  //var response = await http.get("http://192.168.137.1:8888/servicio/$idR");
  var response = await http.get("http://192.168.137.1:8888/monEstudiante/3");

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
  String ser_latitud;
  String ser_longitud;
  String mon_latitud;
  String mon_longitud;

  Post(
    {
      this.ser_latitud,
      this.ser_longitud,
      this.mon_latitud,
      this.mon_longitud
    }
  );

  factory Post.fromJson(Map<String, dynamic> json)
  {
    return Post(
      ser_latitud: json['ser_latitud'],
      ser_longitud: json['ser_longitud'],
      mon_latitud: json['mon_latitud'],
      mon_longitud: json['mon_longitud']
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
  MyHomePageState(this.idR);
  static List<LatLng> points = [];
  static List<LatLng> location = [];
  bool flag=false, statusFlag=false;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: fetchPost(idR),
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              flag == false && points.isEmpty ? snapshot.data.map((post) => buildStopMarkers(post.ser_latitud, post.ser_longitud, post.mon_latitud, post.mon_longitud)).toList() : getUserProximity();
              flag = true;
            }
            else if (snapshot.hasError)
              return Text("No hay paradas cargadas");
            return points.isEmpty ? CircularProgressIndicator() : buildMap();
          }
        )
      )
    );
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

      /*if((userLocation.latitude<xPos && userLocation.longitude<yPos) && (userLocation.latitude>points.first.latitude && userLocation.longitude>points.first.longitude))
        statusFlag=true;
      else if((userLocation.latitude>xNeg && userLocation.longitude<yPos) && (userLocation.latitude<points.first.latitude && userLocation.longitude>points.first.longitude))
        statusFlag=true;
      else if((userLocation.latitude>xNeg && userLocation.longitude>yNeg) && (userLocation.latitude<points.first.latitude && userLocation.longitude<points.first.longitude))
        statusFlag=true;
      else if((userLocation.latitude<xPos && userLocation.longitude>yNeg) && (userLocation.latitude>points.first.latitude && userLocation.longitude<points.first.longitude)) 
        statusFlag=true;
      else
        getFlagStatus();*/
    }
  }

  void getFlagStatus()
  {
    if(statusFlag)
    {
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
            icon: Icon(Icons.location_on),
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
        center: LatLng(points.first.latitude, points.first.longitude),
        maxZoom: 19.0, 
        minZoom: 12,
        zoom: 15,
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
        point: LatLng(location.first.latitude, location.first.longitude),
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

  void buildStopMarkers(String ser_latitud, String ser_longitud, String mon_latitud, String mon_longitud)
  {
    LatLng latlng = new LatLng(double.parse(ser_latitud), double.parse(ser_longitud));
    LatLng latlng1 = new LatLng(double.parse(mon_latitud), double.parse(mon_longitud));
    points.add(latlng);
    location.add(latlng1);
  }
}