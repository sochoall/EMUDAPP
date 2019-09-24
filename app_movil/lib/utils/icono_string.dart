import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'add_alert': Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open': Icons.folder_open,
  'donut_large': Icons.donut_large,
  'school':Icons.school,
  'personal_video': Icons.personal_video,
  'person_add':Icons.person_add,
  'settings_applications':Icons.settings_applications,
  'map':Icons.map,
  'zoom_out_map':Icons.zoom_out_map
};

Icon getIcon(String nombreIcono) {
  //Metodo que regresa un icono
  return Icon(
    //Retorna un icon segun el nombre
    
    _icons[nombreIcono],
    color: Color.fromRGBO(0, 172, 200, 1),
  );
}
