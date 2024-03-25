// Importations des modules
import 'package:flutter/material.dart';
import 'package:lt/provider/provider.dart';
import 'package:lt/views/splash_screen_view.dart';
import 'package:provider/provider.dart';

// Définition de la fonction principale
void main() {

  WidgetsFlutterBinding.ensureInitialized();
    runApp(const Application());

}

// Définition de la classe Application
class Application extends StatelessWidget {

    const Application({super.key});

    @override
    Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            theme: notifier.isDark? notifier.darkTheme : notifier.lightTheme,
            darkTheme: notifier.isDark? notifier.darkTheme : notifier.lightTheme,
              debugShowCheckedModeBanner: false,
              home: const SplashScreenView(),
          );
        }
      ),
    );

  }
  
}
