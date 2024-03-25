// Importations des modules
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lt/couleurs/colors.dart';
import 'package:lt/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Définition de la classe OnBoarding
class OnBoarding extends StatefulWidget {

    const OnBoarding({Key? key}) : super(key: key);

    @override
    OnBoardingState createState() => OnBoardingState();

}

class OnBoardingState extends State<OnBoarding> {

    final _controller = PageController();

    bool _is_last_page = false;

    @override
    void dispose() {

        _controller.dispose();

        super.dispose();

    }

    Widget buildPage({

        required Color color,
        required String urlImage,
        required String title,
        required String subtitle,

    }) =>
        Container(
            color: color,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                  urlImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  ),
                ),
                const SizedBox(
                height: 25,
                ),
                Text(
                title,
                style: const TextStyle(fontFamily: "Poppins",
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                height: 25,
                ),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    subtitle,
                    style: const TextStyle(fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                ),
                )
            ],
            ),
        );

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
            padding: const EdgeInsets.only(bottom: 60),
            child: PageView(
            controller: _controller,
            onPageChanged: (index) {
                setState(() => _is_last_page = index == 2);
            },
            children: [
                buildPage(
                    color: couleur_7,
                    urlImage: 'assets/images/on_boarding_image_one.png',
                    title: 'Bienvenue à vous',
                    subtitle:
                        "Bienvenue à vous au sein de l'application life and truth"),
                buildPage(
                    color: couleur_7,
                    urlImage: 'assets/images/on_boarding_image_two.png',
                    title: 'Participer à distance',
                    subtitle:
                        "Participer à distance aux brèves et séances typiquement chrétiennes"),
                buildPage(
                    color: couleur_7,
                    urlImage: 'assets/images/on_boarding_image_three.png',
                    title: 'Contacter-nous',
                    subtitle:
                        "Contacter-nous pour plus d'informations relatives à l'application ou à un enseignement"),
            ],
            ),
        ),
        bottomSheet: _is_last_page
            ? TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: couleur_7,
                    backgroundColor: couleur_8,
                                        minimumSize: const Size.fromHeight(60),
                ),
                child: const Text(
                    'Commencer',
                    style: TextStyle(fontFamily: "Poppins",
                      color: couleur_3,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                    ),
                ),
                onPressed: () async {
                    final preferences = await SharedPreferences.getInstance();
                    preferences.setBool('onBoarding', true);

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Home(),
                    ));
                },
                )
            : Container(
                color: couleur_8,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                height: 60,
                child: Center(
                  child: SmoothPageIndicator(
                              controller: _controller,
                              count: 3,
                              effect: const WormEffect(
                                  spacing: 16,
                                  dotColor: couleur_3,
                                  activeDotColor: couleur_6,
                              ),
                              onDotClicked: (index) => _controller.animateToPage(index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut),
                              ),
                ),
                ),
        );
    }
}
