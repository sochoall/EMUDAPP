import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {
    return new MaterialApp(
      title: 'Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MapPage(title: 'Fultter Geolocation Map'),
    );
  }
}

class MapPage extends StatefulWidget 
{
  MapPage({Key key, this.title}): super(key: key);
  final String title;

  @override
  MapPageState createState() => new MapPageState();
}

class MapPageState extends State<MapPage> 
{
  Position userLocation, center;
  Geolocator geolocator = Geolocator();
  List<LatLng> tappedPoints = [];
  
  @override
  Widget build(BuildContext context) 
  {
    getCoords();
    return new Scaffold(
      body: userLocation == null ? 
      Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            CircularProgressIndicator()
          ],
        )
      )
      :
      buildMap(),
      /*floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: Icon(Icons.navigation),
            label: 'Ubicacion',
            onTap: ()
            {
              center = userLocation;
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Agregar Marcador',
            onTap: () 
            {
              
            }
          )
        ],
      )*/
    );
  }
  
  _getCurrentPosition()
  {
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, timeInterval: 3000);
    var positionStream;

    positionStream = geolocator.getPositionStream(locationOptions);
        
    return positionStream;
  }

  getCoords()
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
    var markers = tappedPoints.map((latlng)
    {
      return Marker(
        width: 45.0,
        height: 45.0,
        point: latlng,
        builder: (ctx) => Container(
          child: IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.red,
            iconSize: 60.0,
            onPressed: ()
            {
              showModalBottomSheet(
                context: context,
                builder: (builder)
                {
                  return Scaffold(
                    body: Container(
                      color: Colors.white,
                    ),
                    /*floatingActionButton: SpeedDial(
                      animatedIcon: AnimatedIcons.menu_close,
                      overlayOpacity: 0.0,
                      children: [
                        SpeedDialChild(
                          child: Icon(Icons.delete),
                          label: 'Eliminar'
                        ),
                        SpeedDialChild(
                          child: Icon(Icons.edit),
                          label: 'Modificar',
                        ),
                        SpeedDialChild(
                          child: Icon(Icons.add_circle),
                          label: 'Agregar'
                        )
                      ],
                    ),*/
                  );
                }
              );
            },
          ),
        )
      );
    }).toList();

    return FlutterMap(
      options: MapOptions(
        center: center == null ? LatLng(-2.901866, -79.006055) : LatLng(center.latitude, center.longitude),
        maxZoom: 19.0, 
        minZoom: 12,
        zoom: 13,
        onLongPress: _buildUserCustomMark
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:"https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']
        ),
        buildUserMarkLocation(),
        MarkerLayerOptions(markers: markers)
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
              showModalBottomSheet(
                context: context,
                builder: (builder)
                {
                  return Container(
                    color: Colors.white,
                    child: new Center(
                      child: Text('Esta es su ubicacion'),
                    ),
                  );
                }
              );
            },
          ),
        )
      )
    ]);
  }

  _buildUserCustomMark(LatLng latlng)
  {
    setState(() 
    {
      tappedPoints.add(latlng);
      print(latlng);  
    });
  }
}