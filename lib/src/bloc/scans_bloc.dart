

import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc{
  
  // Constructor privado puede aparecer solo 
  // con un guin bajo "new ScansBloc._();"
  // o con un nombre despues del guion bajo
  static final ScansBloc _singleton = new ScansBloc._internal();

  // El factory regresa una instancia de otra cosa,
  // en este caso regresa la instancia "_singleton"
  // que es el constructor privado de la clase
  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){

    // Obtener Scans de la base de datos
    obtenerScans();

  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose(){
    _scansController?.close();
  }

  // Esto se hace normalmente en otro archivo llamado "Events"
  // en este caso son sencillos los metodos asi que estaran aqui mismo
  obtenerScans() async {
    _scansController.sink.add( await DBProvider.db.getTodosScans() );
  }

  agregarScan( ScanModel scan ) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan( int id ) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}