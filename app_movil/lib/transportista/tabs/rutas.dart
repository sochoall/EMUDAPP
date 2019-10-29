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
  final String idRecorrido;
  Rutas(this.idRecorrido);

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      //title: 'ListView Example',
      home: RutaParada(idRecorrido),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RutaParada extends StatefulWidget 
{
  //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  RutaParada(this.idRecorrido);

  @override
  RutasEstado createState() => new RutasEstado(idRecorrido);
}

class RutasEstado extends State<RutaParada> 
{
  bool flag = false;
  Future<Post> post;
  List<String> names= [];
  final String idRecorrido;
  RutasEstado(this.idRecorrido);
  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
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
              flag == false ? snapshot.data.map((post) => getNames(post.nombre)).toList() : print(flag);
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

  buildScrollView()
  {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height /2,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: MyApp(idRecorrido),
            title: Row(
              children: <Widget>[
                Text(
                  "PARADAS  ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black
                  ),
                ),
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
                child: Text(names[index])
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

  printNames()
  {
    String stopNames;
    names.forEach((f) => stopNames = f);
    return stopNames;
  }

  getNames(String name)
  {
    print(name);
    names.add(name);
  }
}