import 'dart:async';
import '../../provider.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/transportista/tabs/mapa.dart'; 

class Post 
{
  String nombre;
  String tEstimado;

  Post(
    {
      this.nombre,
      this.tEstimado
    }
  );

  factory Post.fromJson(Map<String, dynamic> json)
  {
    return Post(
      nombre: json['nombre'],
      tEstimado: json['tiempoPromedio']
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
      home: new RutaParada(idRecorrido),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RutaParada extends StatefulWidget 
{
  @override
  final String idRecorrido;


  RutaParada(this.idRecorrido);
  RutasEstado createState() => new RutasEstado(idRecorrido);
}

class RutasEstado extends State<RutaParada> 
{
  final String idRecorrido;

  Timer timer;
  bool flag = false;
  Future<Post> post;
  RutasEstado(this.idRecorrido);
  static List<String> names = [], time = [];

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
          future: listaParadasProvider.cargarData7(idRecorrido),
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              flag == false && names.isEmpty ? snapshot.data.map((post) => buildLists(post.nombre, post.tEstimado)).toList() : flag;
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
            background: MyApp(idRecorrido),
            title: Row(
              //children: <Widget>[
                //Text("",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                //Icon(Icons.arrow_downward),
                //Icon(Icons.arrow_upward)
              //],
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
                            Text(time[index-1]),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(10.0),
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

  void buildLists(String name, String tiempo)
  {
    names.add(name);
    time.add(tiempo);
  }
}