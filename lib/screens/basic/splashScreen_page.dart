import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/screens/basic/introLoader_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: IntroLoaderPage(),
      photoSize: 150.0,
      // title: Text(
      //   'GrinArmer',
      //   style: TextStyle(
      //       fontWeight: FontWeight.bold, color: white, fontSize: 16.0),
      // ),
      image: Image.asset(
        'assets/GrinArmerLogo.png',
      ),
      backgroundColor: white,
      loaderColor: appColor,
    );
  }
}
