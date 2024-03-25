// Importations des modules
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lt/views/enseignement_view.dart';
import 'package:lt/views/settings_view.dart';

// Définition de la classe Home
class Home extends StatefulWidget {

  bool _navigation_vers_parametres = false;

  Home({super.key, bool navigation_vers_parametres = false}) : _navigation_vers_parametres = navigation_vers_parametres;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _index_bottom_bar = 0;
  Widget body_home = Enseignement();
  
  void _controller_bottom_bar(int index) {

      _index_bottom_bar = index;

      if(index == 1) {
        body_home = Settings();
        this.setState(() {});
      } else {
        body_home = Enseignement();
        this.setState(() {});
      }
  }

  @override
  void initState() {
    super.initState();

    if (widget._navigation_vers_parametres == true) {
      _index_bottom_bar = 1;
      body_home = Settings();
        this.setState(() {});
    }
  }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: body_home,
            bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tv, size: 20,),
            label: "Enseignements",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings, size: 20,),
            label: "Paramètres",
          ),
        ],
        currentIndex: _index_bottom_bar,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _controller_bottom_bar,
      ),
        );
    }
}