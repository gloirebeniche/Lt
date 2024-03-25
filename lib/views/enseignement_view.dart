import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lt/couleurs/colors.dart';
import 'package:video_player/video_player.dart';

class Enseignement extends StatefulWidget {
  const Enseignement({super.key});

  @override
  State<Enseignement> createState() => _EnseignementState();
}

class _EnseignementState extends State<Enseignement> {

  List<Map> _listeEnseignements = [
    {
      "id": "1",
      "titre": "Le choix d'un homme sur la terre",
      "description": "Le choix qu'un homme doit faire dans sa vie est de suivre l'Eternel et de donner sa vie au Seigneur Jesus-Christ qui est mort sur la croix pour nos péchés.",
      "video": "assets/videos/enseignement_one.mp4",
      "is_breve": true,
      "date": "2024-02-29 15:34:45.709732",
    },

    {
      "id": "2",
      "titre": "Le meilleur en jeu de la nouvelle naissance",
      "description": "Un jeu de la nouvelle naissance est de mettre en pratique la parole.",
      "video": "assets/videos/enseignement_two.mp4",
      "is_breve": false,
      "date": "2024-02-29 15:34:45.709732",
    }
  ];

  Future<Widget> _fetchData() async {

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.dark ? couleur_7 : couleur_12,
            body: Center(
              child: FutureBuilder<Widget>(future: _fetchData(), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: couleur_3,
                  );
                }else if (snapshot.hasData) {
                  if (_listeEnseignements.length >= 1) {
                        return EnseignementPage(
                    listeEnseignements: _listeEnseignements,
                  );
                  } else {
                    return Center(
                      child:
                          Text("Aucune brève trouvée",
                          style: TextStyle(fontFamily: "Poppins",
                            color: couleur_3,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                      ),
                  );
                }
              } else {
              return CircularProgressIndicator(
                color: couleur_3,
              );
            }
              }),
            )

        );
  }
}

class EnseignementPage extends StatefulWidget {
  List<Map> _listeEnseignements;

  EnseignementPage({
    Key? key,
    required List<Map> listeEnseignements,
  })  : _listeEnseignements = listeEnseignements,
        super(key: key);

  @override
  State<EnseignementPage> createState() => _EnseignementPageState();
}

class _EnseignementPageState extends State<EnseignementPage> {

  bool forDownload = false;

  Future rafraichirEnseignements() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        shadowColor: couleur_13,
        foregroundColor: couleur_13,
        surfaceTintColor: couleur_13,
        backgroundColor: couleur_13,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                  text: "Téléchargements",
                  style: TextStyle(
                    color: couleur_3,
                    fontSize: 20,
                    fontWeight: forDownload ? FontWeight.bold : FontWeight.normal,
                    fontFamily: 'Poppins',
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    forDownload =  true;
                      this.setState(() {
                        
                      });
                  }),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "|",
              style: TextStyle(
                color: couleur_3,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              width: 5,
            ),
            RichText(
              text: TextSpan(
                  text: "Pour moi",
                  style: TextStyle(
                    color: couleur_3,
                    fontSize: 20,
                    fontWeight: forDownload ? FontWeight.normal : FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      forDownload =  false;
                      this.setState(() {
                        
                      });
                    }),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: rafraichirEnseignements,
        backgroundColor: couleur_3,
        color: couleur_6,
        child: CarouselSlider(
          options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: false,
              height: double.infinity,
              scrollDirection: Axis.vertical,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) async {
  
              },
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn),
          items: widget._listeEnseignements.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  color: Theme.of(context).brightness == Brightness.dark ? couleur_7 : couleur_12,
                  child: Stack(
                    children: [
                      VideoWidget(
                        videoUrl: Uri.parse(item['video']),
                      ),
                      VideoContent(
                        id: item['id'],
                        titre: item['titre'],
                        description: item['description'],
                        video: item['video'],
                        date: item['date'],
                        is_breve: item['is_breve'],
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class VideoWidget extends StatefulWidget {
  Uri _videoUrl;

  VideoWidget({
    Key? key,
    required Uri videoUrl,
  })  : _videoUrl = videoUrl,
        super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState(_videoUrl);
}

class _VideoWidgetState extends State<VideoWidget> {

  Color couleurIconePlay = couleur_13;

  Color couleurIconePlay2 = couleur_13;

  late VideoPlayerController _controller = VideoPlayerController.asset("");

  Uri videoUrl;

  _VideoWidgetState(this.videoUrl);

  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    _controller = VideoPlayerController.networkUrl(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {

    super.dispose();

    _controller.pause();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      VideoPlayer(_controller),
      Align(
        alignment: Alignment.bottomCenter,
        child: VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          colors: const VideoProgressColors(
              backgroundColor: couleur_14,
              playedColor: couleur_3,
              bufferedColor: couleur_14),
        ),
      ),
      Center(
        child: InkWell(
          onTap: () {
            if (_controller.value.isPlaying) {
              _controller.pause();

              setState(() {
                couleurIconePlay = couleur_15;

                couleurIconePlay2 = couleur_3;
              });
            } else {
              _controller.play();

              setState(() {
                couleurIconePlay = couleur_13;

                couleurIconePlay2 = couleur_13;
              });
            }
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: couleurIconePlay,
            child: Icon(
              Icons.play_arrow_rounded,
              size: 40,
              color: couleurIconePlay2,
            ),
          ),
        ),
      ),
    ]);
  }
}

// ignore: must_be_immutable
class VideoContent extends StatefulWidget {
  String id = "";
  String titre = "";
  String description = "";
  String video = "";
  String date = "";
  bool is_breve;

  VideoContent({
    super.key,
    required this.id,
    required this.titre,
    required this.description,
    required this.video,
    required this.date,
    required this.is_breve,
  });

  @override
  State<VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<VideoContent> {
  bool affichageDescription =
      false;

  // ignore: annotate_overrides
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.is_breve == true
                    ? Container(
                        constraints: BoxConstraints(
                            maxHeight: 30,
                            minHeight: 30,
                            maxWidth: 85,
                            minWidth: 85),
                        alignment: Alignment.center,
                        foregroundDecoration: BoxDecoration(
                            color: couleur_17,
                            borderRadius: BorderRadius.circular(15)),
                        width: 90,
                        height: 30,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.slow_motion_video_sharp,
                                color: couleur_3,
                                size: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Brève",
                                style: TextStyle(
                                  color: couleur_3,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ]),
                      )
                    : Container(
                        constraints: BoxConstraints(
                            maxHeight: 30,
                            minHeight: 30,
                            maxWidth: 85,
                            minWidth: 85),
                        alignment: Alignment.center,
                        foregroundDecoration: BoxDecoration(
                            color: couleur_17,
                            borderRadius: BorderRadius.circular(15)),
                        width: 90,
                        height: 30,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.ondemand_video_rounded,
                                color: couleur_3,
                                size: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Séance",
                                style: TextStyle(
                                  color: couleur_3,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ]),
                      ),
                Text(
                  this.widget.titre,
                  style: const TextStyle(fontFamily: "Poppins",
                    color: couleur_3,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                affichageDescription == true
                    ? RichText(
                        text: TextSpan(
                            text: widget.description,
                            style: const TextStyle(fontFamily: "Poppins",
                              color: couleur_3,
                              fontSize: 15,
                                  fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (affichageDescription == true) {
                                  setState(() {
                                    affichageDescription = false;
                                  });
                                }
                              }),
                      )
                    : const SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    affichageDescription == false
                        ? Text(
                            widget.description.substring(0, 15) + "...",
                            style: const TextStyle(fontFamily: "Poppins",
                              color: couleur_3,
                              fontSize: 15,
                                  fontWeight: FontWeight.w500,
                            ),
                          )
                        : const SizedBox.shrink(),
                    affichageDescription == false
                        ? RichText(
                            text: TextSpan(
                                text: "Afficher plus",
                                style: const TextStyle(fontFamily: "Poppins",
                                  color: couleur_3,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (affichageDescription == false) {
                                      setState(() {
                                        affichageDescription = true;
                                      });
                                    }
                                  }),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Publiée le " +
                      DateTime.parse(widget.date).day.toString() +
                      "/" +
                      DateTime.parse(widget.date).month.toString() +
                      "/" +
                      DateTime.parse(widget.date).year.toString() +
                      " à " +
                      DateTime.parse(widget.date).hour.toString() +
                      "h " +
                      DateTime.parse(widget.date).minute.toString(),
                  style: const TextStyle(fontFamily: "Poppins",
                    fontSize: 13,
                    color: couleur_14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
              width: 80,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              //Share.share("Suivez plus d'enseignements comme " + this.widget.titre + " : " + this.widget.video + " sur l'application chrétienne life and truth disponible sur Google play et Apple store.");

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Icon(Icons.verified, size: 15, color: couleur_3,),
                                      SizedBox(width: 10,),
                                      Text(
                                    "Enseignement partagé avec succès",
                                    style: TextStyle(
                                        color: couleur_3,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                    textAlign: TextAlign.left,
                                  ),

                                    ],
                                  ),
                                  elevation: 100,
                                  backgroundColor: couleur_18,
                                ),
                              );
                            },
                            child: Icon(
                              CupertinoIcons.arrowshape_turn_up_right_fill,
                              size: 40,
                              color: couleur_3,
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: couleur_7,
                              shape: const CircleBorder(),
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextButton(
                            onPressed: () {

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Icon(Icons.verified, size: 15, color: couleur_3,),
                                      SizedBox(width: 10,),
                                      Text(
                                    "Enseignement téléchargé avec succès",
                                    style: TextStyle(
                                        color: couleur_3,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                    textAlign: TextAlign.left,
                                  ),

                                    ],
                                  ),
                                  elevation: 100,
                                  backgroundColor: couleur_18,
                                ),
                              );
                            },
                            child: Icon(
                              Icons.download,
                              size: 40,
                              color: couleur_3,
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: couleur_7,
                              shape: const CircleBorder(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ])),
        ],
      ))
    ]);
  }
}
