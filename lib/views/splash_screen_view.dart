// Importations des modules
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lt/views/home_view.dart';
import 'package:lt/views/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Définition de la classe SplashScreenView
class SplashScreenView extends StatefulWidget {
    
    const SplashScreenView({super.key});

    @override State<SplashScreenView> createState() => _SplashScreenViewState();

}

class _SplashScreenViewState extends State<SplashScreenView> {

    @override
    void initState() {

        super.initState();

        Timer(const Duration(seconds: 3), () async {

          SharedPreferences preferences = await SharedPreferences.getInstance();

          
          bool? preferenceOnBoarding = preferences.getBool('onBoarding');

          if(preferenceOnBoarding == true) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => Home())));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => OnBoarding())));
          }
        });

    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
          backgroundColor: Theme.of(context).splashColor,
            body: Center(
                child: Image.asset('assets/images/icone_light_mode.png',
                width: 200,
                height: 200,),
            )
        );
    }
}