import 'package:after_layout/after_layout.dart';
import 'package:distributer_application/auth/login_page.dart';
import 'package:distributer_application/home/home_page.dart';
import 'package:distributer_application/screens/basic/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroLoaderPage extends StatefulWidget {
  @override
  _IntroLoaderPageState createState() => _IntroLoaderPageState();
}

class _IntroLoaderPageState extends State<IntroLoaderPage>
    with AfterLayoutMixin<IntroLoaderPage> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      print(seen);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var status = prefs.getBool('isLoggedIn') ?? false;
      var uid = status == true ? prefs.getString("uid") : null;
      var email = status == true ? prefs.getString("email") : null;
      var name = status == true ? prefs.getString("name") : null;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => status == false
              ? LoginPage()
              : HomePage(
                  email: email,
                  name: name,
                )));
    } else {
      print(seen);
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IntroPage()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
