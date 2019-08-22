import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:qrreaderapp/src/utils/utils.dart' as utils;

// import 'package:qrcode_reader/qrcode_reader.dart';
// import 'package:qrreaderapp/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.delete_forever ),
            onPressed: scansBloc.borrarScanTodos,
          )
        ],
      ),
      body: _callPage( currentIndex ),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.filter_center_focus ),
        onPressed: () => _scanQR( context ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context ) async {

    // https://www.google.com
    // geo:40.71902904250759,-73.99632826289064

    String futureString = 'https://www.google.com';

    // try{
    //   futureString = await new QRCodeReader().scan();
    // } catch (error) {
    //   futureString = error.toString();
    // }

    // print('futureString: $futureString');

    if( futureString != null ) {
      
      final scan = ScanModel( valor: futureString );
      scansBloc.agregarScan(scan);

      final scan2 = ScanModel( valor: 'geo:40.71902904250759,-73.99632826289064' );
      scansBloc.agregarScan(scan2);
      // DBProvider.db.nuevoScan( scan );
      
      if( Platform.isIOS ){
        Future.delayed( Duration( milliseconds: 750 ), () {
          utils.arbriScan(context, scan);
        });
      } else {
        utils.arbriScan(context, scan);
      }

    }

  }

  Widget _callPage( int paginaActual ){

    switch( paginaActual ){

      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default: return MapasPage();

    }

  }

  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      // elemento donde se inicializa
      currentIndex: currentIndex,
      // manda el index dentro de la funcion
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      // tiene que ser mas de 1 item si no marca error
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.map ),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.brightness_5),
          title: Text('Direcciones')
        )
      ],
    );

  }
}