import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_movil/transportista/tabs/mapa.dart';

Future<List<Post>> fetchPostP() async
{
  var response = await http.get("http://192.168.137.1:8888/parada/1");

  if(response.statusCode == 200)
  {
    final jsonresponse = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Post> listOfRoutes = jsonresponse.map<Post>((json)
    {
      return Post.fromJson(json);
    }).toList();

    return listOfRoutes;
  }  
  else
    throw Exception('Failed to get items');
}

class Post
{
  String nombre;

  Post(
    {
      this.nombre,
    }
  );

  factory Post.fromJson(Map<String, dynamic> json)
  {
    return Post(
      nombre: json['nombre'],
    );
  }
}

class Rutas extends StatelessWidget 
{
  @override
   final String idRecorrido;
  Rutas(this.idRecorrido);
  
  Widget build(BuildContext context) 
  {
    return new MaterialApp(
      home: new RutaParada(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RutaParada extends StatefulWidget 
{
  @override
  RutasEstado createState() => new RutasEstado();
}

class RutasEstado extends State<RutaParada> 
{
  Timer timer;
  bool flag = false;
  Future<Post> post;
  static List<String> names = [];

  @override
  void initState() 
  {
    super.initState();
    new Timer.periodic(Duration(seconds: 1), (Timer t) => setState((){}));
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold(
      body: names == null ?
      Center(
        child: CircularProgressIndicator(),
      )
      :
      Center(
        child: FutureBuilder<List<Post>>(
          future: fetchPostP(),
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              flag == false && names.isEmpty ? snapshot.data.map((post) => buildListNames(post.nombre)).toList() : flag;
              flag = true;
            }
            else if (snapshot.hasError)
              return Text("No hay paradas cargadas");
            return buildScrollView();
          }
        )
      )
    );
  }

  CustomScrollView buildScrollView()
  {
    return new CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height /2,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: MyApp(""),
            title: Row(
              children: <Widget>[
                Text("PARADAS  ",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Icon(Icons.arrow_downward),
                Icon(Icons.arrow_upward)
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) 
                  {
                    return index/names.length == 0
                    ?
                    Container(
                      color: Colors.lightBlue,
                      height: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Parada", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                            Text("Tiempo Estimado", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))
                          ],
                        )
                      ),
                      padding: EdgeInsets.all(10.0),
                    )
                    :
                    Container(
                      height: 50,
                      color: index-1 == 0 ? Colors.grey.withOpacity(0.2) : null,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: names.isEmpty ? <Widget>[CircularProgressIndicator()] : <Widget>[
                            Text(names[index-1]),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(10.0),
                      /*child: Center(
                        child: names.isEmpty ? CircularProgressIndicator() : Text(names[index-1]),
                      ),*/
                    );
                  },
                  childCount: names.length+1
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void buildListNames(String name)
  {
    names.add(name);
  }
}