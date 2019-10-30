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
              flag == false && names == null ? snapshot.data.map((post) => buildListNames(post.nombre)).toList() : print(flag);
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
    print(names);
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
                    return Container(
                      alignment: Alignment.center,
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          Container(
                            height: 50,
                            color: Colors.amber[600],
                            child: Center(
                              child: Text(names[index]),
                            ),
                          )
                        ],
                      )
                    );
                  },
                  childCount: names.length
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