import 'package:bgmimobile/verify/verify_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'controller/fb_controller.dart';
import 'fb/fb.dart';
import 'firebase_options.dart';
import 'home/home_scree.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BGMI Mobile',
        theme: ThemeData(
          fontFamily: 'block',
          primarySwatch: Colors.blue,
        ),
        home: // const VerifyPageScreen()

            const MyHomePage(
          title: 'BGMI Mobile',
        ),
      ),
    );
  }
}
