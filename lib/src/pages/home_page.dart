import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage( currentIndex ),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
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