// Importations des modules
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lt/couleurs/colors.dart';
import 'package:lt/provider/provider.dart';
import 'package:lt/views/infos_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Définition de la classe Settings
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {    
  
    return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Paramètres",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),

                      const SizedBox(height: 30,),

                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Thème de l'application",
                        style: Theme.of(context).textTheme.bodyText2)
                      ),

                      const SizedBox(height: 10,),

                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                                          CrossAxisAlignment.center,
                              children: [
                                Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.dark_mode,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Mode sombre",
                                              ),
                                            ],
                                          ),
                                        ),
                                Consumer<UiProvider>(
                                  builder: (context, UiProvider notifier, child) {
                                  return Switch(
                                          value: notifier.isDark,
                                          onChanged: (value) => notifier.changeTheme(),
                                            );
                                          }
                                      ),
                              ],
                            ),
                          ],
                        ),
                              decoration: BoxDecoration(
                                  color:  Theme.of(context).brightness == Brightness.dark ? couleur_1 : couleur_2,
                                  borderRadius: BorderRadius.circular(10)),
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Aide",
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Column(
                                children: [Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.messenger_outline_sharp,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Contactez-nous",
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(onPressed: () {

                                          showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Theme.of(context).brightness == Brightness.dark ? couleur_1 : couleur_3,
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                            barrierColor: couleur_4.withOpacity(0.5),
                                            builder: (context) {
                                              return Container(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      splashColor: Theme.of(context).brightness == Brightness.dark ? couleur_1 : couleur_5.withOpacity(0.5),
                                                      iconColor: couleur_6,
                                                      leading: Icon(FontAwesomeIcons.phone, size: 20),
                                                      title: Text('Appel téléphonique',
                                                      style: TextStyle(fontFamily: "Poppins",
                                                        fontSize: 15,
                                                      ),),
                                                      shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                                      onTap: () async {
                                                        if(!await launch("tel:+242068478060")) throw Fluttertoast.showToast(msg: "Impossible d'effectuer l'appel.", toastLength: Toast.LENGTH_LONG, gravity:  ToastGravity.BOTTOM);
                                                      },
                                                    ),
                                                    ListTile(
                                                      splashColor: Theme.of(context).brightness == Brightness.dark ? couleur_1 : couleur_5.withOpacity(0.5),
                                                      iconColor: couleur_6,
                                                      leading: Icon(FontAwesomeIcons.google, size: 20),
                                                      title: Text('Messagerie google',
                                                      style: TextStyle(fontFamily: "Poppins",
                                                        fontSize: 15,
                                                      ),),
                                                      onTap: () async {
                                                        if(!await launch("mailto:franckmazikous@gmail.com")) throw Fluttertoast.showToast(msg: "Impossible d'écrire un message.", toastLength: Toast.LENGTH_LONG, gravity:  ToastGravity.BOTTOM);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );

                                        }, icon: Icon(
                                          CupertinoIcons.chevron_right,
                                          size: 20,
                                        ),
                                        highlightColor: couleur_7,)
                                      ],
                                    ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.info,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Infos de l'application",
                                              ),
                                            ],
                                          ),
                                        ),

                                        IconButton(onPressed: () async {
                                          
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Infos()));
                                        }, icon: Icon(
                                          CupertinoIcons.chevron_right,
                                          size: 20,
                                        ),
                                        highlightColor: couleur_7,)
                                      ],
                                    ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.dark ? couleur_1 : couleur_2,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                    ],
                  ),
                ),
              ),
            )
        );
  }
}