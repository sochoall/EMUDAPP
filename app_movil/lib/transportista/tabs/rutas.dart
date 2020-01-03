import 'dart:async';
import '../../provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/transportista/tabs/mapa.dart';

class Post {
  String nombre;
  String tEstimado;
  Post({this.nombre, this.tEstimado});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(nombre: json['nombre'], tEstimado: json['tiempoPromedio']);
  }
}

class Rutas extends StatelessWidget {
  @override
  final String idRecorrido;
  Rutas(this.idRecorrido);
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new RutaParada(idRecorrido),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RutaParada extends StatefulWidget {
  @override
  final String idRecorrido;
  RutaParada(this.idRecorrido);
  RutasEstado createState() => new RutasEstado(idRecorrido);
}

class RutasEstado extends State<RutaParada> {
  Timer timer;
  bool flag = false;
  Future<Post> post;
  final String idRecorrido;
  RutasEstado(this.idRecorrido);
  List<int> hours = [], minutes = [], total = [];
  static List<String> names = [], time = [], finalTime = [];
  @override
  void initState() {
    super.initState();
    new Timer.periodic(Duration(seconds: 1), (Timer) {
      if (mounted) setState(() {});
    });
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
            if (snapshot.hasData) 
            {
              flag == false && names.isEmpty ? snapshot.data.map((post) => buildLists(post.nombre, post.tEstimado)).toList() : flag;
              flag = true;
            } 
            else if (snapshot.hasError)
              return Text("No hay paradas cargadas");
            buildTimeList();
            return buildScrollView();
          }
        )
      )
    );
  }

  CustomScrollView buildScrollView() {
    return new CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height / 2,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: MyApp(idRecorrido),
          ),
        ),
        SliverFillRemaining(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return index / names.length == 0
                      ? Container(
                          color: Colors.lightBlue,
                          height: 50,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Parada",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text("Tiempo Estimado",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ],
                          )),
                          padding: EdgeInsets.all(10.0),
                        )
                      : Container(
                          height: 50,
                          color: index - 1 == 0
                              ? Colors.grey.withOpacity(0.2)
                              : null,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: names.isEmpty
                                  ? <Widget>[CircularProgressIndicator()]
                                  : <Widget>[
                                      Text(names[index - 1],
                                          style: index - 1 == 0
                                              ? TextStyle(color: Colors.red)
                                              : TextStyle(color: Colors.black)),
                                      Text(finalTime[index - 1],
                                          style: index - 1 == 0
                                              ? TextStyle(color: Colors.red)
                                              : TextStyle(color: Colors.black)),
                                    ],
                            ),
                          ),
                          padding: EdgeInsets.all(10.0),
                        );
                }, childCount: names.length + 1),
              )
            ],
          ),
        )
      ],
    );
  }

  void buildLists(String name, String tiempo) {
    List<String> timeValues = tiempo.split(":");

    names.add(name);
    time.add(tiempo);
    minutes.add(int.parse(timeValues[1]));
  }

  void buildTimeList() {
    int cont = 0;

    for (var i = 0; i < minutes.length; i++) {
      if (i == 0) {
        hours.add(cont);
        total.add(minutes[i]);
      } else if (minutes[i] + total[i - 1] >= 60) {
        cont++;
        hours.add(cont);
        total.add((minutes[i] + total[i - 1]) - 60);
      } else {
        hours.add(cont);
        total.add(minutes[i] + total[i - 1]);
      }
      finalTime.add(
          "${DateFormat('hh:mm:ss').format(DateTime.now().add(new Duration(hours: hours[i], minutes: total[i])))}");
    }
  }
}
