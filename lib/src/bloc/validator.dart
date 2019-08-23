import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

class Validators {

  // el stream transformer recibe un tipo de dato que es <List<ScanModel>>
  // y retorna en este caso el mismo tipo de dato pero filtrado <List<ScanModel>>
  final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: ( scans, sink ){

      final geoScans = scans.where( (s) => s.tipo == 'geo' ).toList();
      sink.add(geoScans);

    }
  );

  final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: ( scans, sink ){

      final geoScans = scans.where( (s) => s.tipo == 'http' ).toList();
      sink.add(geoScans);

    }
  );

}