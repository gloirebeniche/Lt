// Importations des modules
import 'package:flutter/material.dart';
import 'package:lt/couleurs/colors.dart';
import 'package:lt/views/home_view.dart';

class Infos extends StatelessWidget {

  const Infos({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home(navigation_vers_parametres: true,)));
        return true;
      },
      child: Scaffold(
        body: SafeArea(child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Life and Truth",
                                      style: TextStyle(fontFamily: "Poppins",
                                      color: Theme.of(context).brightness == Brightness.dark ? couleur_3 : couleur_9,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,),
                                      Text("Version 1.0",
                                      style: TextStyle(fontFamily: "Poppins",
                                      color: Theme.of(context).brightness == Brightness.dark ? couleur_10 : couleur_11,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.center,),
                                      Image.asset(Theme.of(context).brightness == Brightness.dark ? 'assets/images/icone_light_mode.png' : 'assets/images/icone_dark_mode.png',
                                      width: 200,
                                      height: 200,),
      
                                      Text("Projet chrétien open source",
                                      style: TextStyle(fontFamily: "Poppins",
                                      color: Theme.of(context).brightness == Brightness.dark ? couleur_10 : couleur_11,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),)
      
                                    ],
                                  ),
                                )
        )
      ),
    );
  }
}