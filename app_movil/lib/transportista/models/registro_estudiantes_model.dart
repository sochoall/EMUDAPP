
class Estudiante {
  int id;
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String telefono;
  String correo;
  int estado;
  int insId;
  bool verificado;

  Estudiante({this.id, this.cedula= '', this.nombre= '', this.apellido= '', this.direccion= '',
      this.telefono= '', this.correo= '', this.estado=0, this.insId=0, this.verificado=false});

}
