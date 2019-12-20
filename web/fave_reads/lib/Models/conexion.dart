import 'package:postgres/postgres.dart';

class Conexion {
  // PostgreSQLConnection conexion = PostgreSQLConnection("localhost", 5432, "emov",username: "postgres", password: "1234");
  PostgreSQLConnection conexion = PostgreSQLConnection("localhost", 5432, "emov", username: "postgres", password: "admin");
  Future conectar() async {
    await conexion.open();
    print('conexion establecida');
  }

  Future desconectar() async {
    if (!conexion.isClosed) {
      await conexion.close();
    }
  }

  Future<List<dynamic>> obtenerTabla(String sql) async {
    List<dynamic> results;

    try {
      await conectar();
      results = await conexion.query(sql);
    } catch (Exception) {
      print(Exception);
    } finally {
      await desconectar();
    }

    return results;
  }

  Future<void> operaciones(String sql) async {
    try {
      await conectar();
      await conexion.query(sql);
      print('Se ha completado exitosamente');
    } catch (Exception) {
      print(Exception);
      print('Ha fallado');
    } finally {
      await desconectar();
    }
  }

  Future<int> busqueda(String sql) async {
    List<dynamic> results;
    int cont;
    try {
      results = await conexion.query(sql);
      cont = int.parse(results[0][0].toString());
    } catch (Exception) {
      print(Exception);
    } finally {}

    return cont;
  }
}
