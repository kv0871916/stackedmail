import 'package:bgmimobile/fb/fb.dart';
import 'package:bgmimobile/home/video.dart';
import 'package:bgmimobile/twitter/twitter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0325,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        'assets/app.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BGMI MOBILE",
                        style: TextStyle(
                            color: Colors.amber.shade800, fontSize: 12),
                      ),
                      const Text(
                        "The original Battle Royale,\nthe first and the best!",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.menu),
              const Icon(Icons.shopping_cart)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VideoApp(),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/alert.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 10),
                    child: Text(
                      'Choose your free rewards here now!'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 1,
                            color: Colors.amber.shade700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: kIsWeb
                  ? MediaQuery.of(context).size.height * 0.725
                  : MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(8.0),
              child: Gridtiems(controller: controller),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Follow us".toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                      ),
                      FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Colors.white,
                      ),
                      FaIcon(
                        FontAwesomeIcons.youtube,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/footer-img.png',
                    fit: BoxFit.contain,
                  ),
                  Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "ⓒ 2017 KRAFTON, Inc. All rights reserved.\n",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: "block"),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    "ⓒ 2018-2022 Tencent. All rights reserved.\n",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            TextSpan(
                                text: "ⓒ",
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            TextSpan(
                                text:
                                    "Privacy Policy | Tencent Games User Agreement",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Gridtiems extends StatelessWidget {
  final ScrollController controller;
  const Gridtiems({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> image = <String>[
      "assets/1.png",
      "assets/2.png",
      "assets/3.png",
      "assets/4.png",
      "assets/5.png",
      "assets/6.png",
      "assets/7.png",
      "assets/8.png",
      "assets/9.png",
    ];

    return GridView.builder(
      controller: controller,
      itemCount: image.length,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer(
              duration: const Duration(seconds: 2),
              enabled: true,
              child: Image.asset(image[index]),
            ),
            GestureDetector(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: 300,
                          color: Colors.black.withOpacity(0.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    "assets/popup-navbar.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Reward Confirmation".toUpperCase(),
                                          style: const TextStyle(
                                            color: Color(0xFF50362d),
                                            fontWeight: FontWeight.bold,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1,
                                                color: Color(0xFFfef5ea),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Image.asset(
                                            "assets/popup-close.png",
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "Are you sure to collect this reward?",
                                style: TextStyle(
                                  color: Color(0xFFfef5ea),
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Image.asset(
                                    image[index],
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    "assets/popup-footer.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)), //this right here
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Image.asset(
                                                              "assets/popup-navbar.png",
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Account Login"
                                                                        .toUpperCase(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xFF50362d),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/popup-close.png",
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.02,
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "Login to receive your selected reward"
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFFfef5ea),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            //FB Login

                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return const AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(32.0))),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 10.0),
                                                                  content:
                                                                      FBClone(),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.75,
                                                            alignment: Alignment
                                                                .center,
                                                            color: const Color(
                                                                0xFF1778f2),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                const FaIcon(
                                                                  FontAwesomeIcons
                                                                      .facebookSquare,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  "Log in using Facebook account"
                                                                      .toUpperCase(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFFfef5ea),
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            //FB Login

                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return const AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(32.0))),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 10.0),
                                                                  content:
                                                                      TwitterClone(),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.75,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            margin:
                                                                EdgeInsets.only(
                                                              bottom: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.025,
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            color: const Color(
                                                                0xFF08a0e9),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                const FaIcon(
                                                                  FontAwesomeIcons
                                                                      .twitterSquare,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  " Log in using Twitter account"
                                                                      .toUpperCase(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFFfef5ea),
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: SizedBox(
                                          height: 50,
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/btn-on.png",
                                                  fit: BoxFit.fitWidth,
                                                ),
                                                Text(
                                                  "Collect".toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/btn-item.png",
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    'Collect'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
