import 'package:distributer_application/screens/basic/intro_page.dart';
import 'package:distributer_application/screens/basic/introLoader_page.dart';
import 'package:distributer_application/screens/basic/splashScreen_page.dart';
import 'package:flutter/material.dart';
import 'package:distributer_application/auth/login_page.dart';
import 'package:distributer_application/auth/register_page.dart';
import 'package:distributer_application/auth/reset_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/home_page.dart';

void main() {
  runApp(MyApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var status = prefs.getBool('isLoggedIn') ?? false;
//   var uid = status == true ? prefs.getString("uid") : null;
//   var email = status == true ? prefs.getString("email") : null;
//   print(status);
//   print(uid);
//   runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'GrinArmer',
//       theme: ThemeData(
//         fontFamily: 'Nexa',
//         primarySwatch: Colors.grey,
//       ),
//       home: status == false ? LoginPage() : HomePage(uid: uid, email: email)));
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GrinArmer',
      theme: ThemeData(
        fontFamily: 'Livvic',
        primarySwatch: Colors.grey,
      ),
      home: SplashScreenPage(),
    );
  }
}
