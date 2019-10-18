import 'package:fave_reads/Controller/check_estudiante_controller.dart';
import 'package:fave_reads/Controller/estudiante_controller.dart';
import 'package:fave_reads/Controller/login_controller.dart';
import 'package:fave_reads/Controller/monitoreo_controller.dart';
import 'package:fave_reads/Controller/opcion_controller.dart';
import 'package:fave_reads/Controller/parada_controller.dart';
import 'package:fave_reads/Controller/periodo_controller.dart';
import 'package:fave_reads/Controller/recorrido_controller.dart';
import 'package:fave_reads/Controller/sentido_controller.dart';
import 'package:fave_reads/Controller/tipo_institucion_controller.dart';
import 'package:fave_reads/Controller/tipo_monitoreo_controller.dart';
import 'package:fave_reads/Controller/tipo_parada_controller.dart';
import 'package:fave_reads/Controller/tipo_vehiculo_controller.dart';
import 'package:fave_reads/Controller/usuario_controller.dart';
import 'package:fave_reads/Models/check_estudiante.dart';
import 'package:fave_reads/Models/estudiante.dart';
import 'Controller/estado_objetos_controller.dart';
import 'Controller/funcionario_controller.dart';
import 'Controller/institucion_controller.dart';
import 'Controller/objetos_perdidos_controller.dart';
import 'Controller/representante_controller.dart';
import 'Controller/rol_controller.dart';
import 'Controller/ruta_controller.dart';
import 'Controller/tipo_servicio_controller.dart';
import 'Controller/vehiculo_controller.dart';
import 'fave_reads.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class FaveReadsChannel extends ApplicationChannel {
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    //final persistentStore =PostgreSQLPersistentStore.fromConnectionInfo("postgres", "1234", "192.169.4.3", 5432, "emov");
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router()

      // Prefer to use `link` instead of `linkFunction`.
      // See: https://aqueduct.io/docs/http/request_controller/

      ..route('/funcionario/[:id]').link(() => FuncionarioController())
      ..route('/institucion/[:id]').link(() => InstitucionController())
      ..route('/tipoInstitucion/[:id]').link(() => TipoInstitucionController())
      ..route('/usuario/[:id]').link(() => UsuarioController())
      ..route('/opcion/[:id]').link(() => OpcionController())
      ..route('/rol/[:id]').link(() => RolController())
      ..route('/representante/[:id]').link(() => RepresentanteController())
      ..route('/login/[:datos]').link(() => LoginController())
      ..route('/vehiculo/[:id]').link(() => VehiculoController())
      ..route('/tipoServicio/[:id]').link(() => TipoServicioController())
      ..route('/rutas/[:id]').link(() => RutaController())
      ..route('/objetosPerdidos/[:id]').link(() => ObjetosPerdidosController())
      ..route('/estadoObjetos/[:id]').link(() => EstadoObjetosController())
      ..route('/periodo/[:id]').link(() => PeriodoController())
      ..route('/parada/[:id]').link(() => ParadaController())
      ..route('/recorrido/[:id]').link(() => RecorridoController())
      ..route('/monitoreo/[:id]').link(() => MonitoreoController())
      ..route('/sentido/[:id]').link(() => SentidoController())
      ..route('/tipoVehiculo/[:id]').link(() => TipoVehiculoController())
      ..route('/tipoParada/[:id]').link(() => TipoParadaController())
      ..route('/tipoMonitoreo/[:id]').link(() => TipoMonitoreoController())
      ..route('/estudiante/[:id]').link(() => EstudianteController())
      ..route('/check_estudiante/[:id]').link(() => CheckEstudianteController());

    return router;
  }
}
