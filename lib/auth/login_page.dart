import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:distributer_application/auth/register_page.dart';
import 'package:distributer_application/auth/reset_password.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_page.dart';
import 'package:http/http.dart' as http;

import 'basicInfo_page.dart';
import 'showErrDialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

const String url =
    "https://betasources.in/projects/grin-armer/mobile-user-login";

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String password;
  String email;

  // email validator
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Invalid email address"),
  ]);

  // password validator
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: "Password is required"),
    MinLengthValidator(6, errorText: "Minimum 6 characters required"),
  ]);

  // handle sign in onpressed button
  void handleSignIn() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();

//      signin(email.trim(), password, context).then((value) async {
//        if (value != null) {
//          Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//                builder: (context) => HomePage(email: value.email),
//              )).then((_) => formkey.currentState.reset());
//        }
//      });

//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      prefs.setBool("isLoggedIn", true);
//      prefs.setString("email", email);

      //login (php) --starts--
      http.Response response = await http.post(
        url,
        body: {
          'username': email,
          'password': password,
        },
      );

      print("response is");
      print(response.statusCode);
      print(response.body);
      var responseData = jsonDecode(response.body);
      print(responseData["success"]);
      if (response.statusCode == 200) {
        if (responseData["success"] == false) {
          return showErrDialog(context, responseData['msg']);
        } else {
          if (responseData['phone'] != "") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            List<String> cartProducts = [];
            prefs.setBool("isLoggedIn", true);
            prefs.setString("email", email);
            prefs.setString("name", responseData['name']);
            List c = prefs.getStringList("cartProducts");
            print('cartProducts');
            print(c);
            if (c == null) {
              prefs.setStringList("cartProducts", cartProducts);
            }
            // c == null ?? prefs.setStringList("cartProducts", cartProducts);
            List cc = prefs.getStringList("cartProducts");
            print('cartProducts');
            print(cc);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    email: responseData['email'],
                    name: responseData['name'],
                  ),
                )).then(
              (_) => formkey.currentState.reset(),
            );
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BasicInfoPage(
                    email: responseData['email'],
                    name: responseData['name'],
                  ),
                )).then(
              (_) => formkey.currentState.reset(),
            );
          }
        }
      } else {
        throw Exception("Error, ${response.statusCode}");
      }
      //login (php) --end--
    }
  }

  // forgot password field
  @override
  Widget build(BuildContext context) {
    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(builder: (_) => ResetPassword()),
                  )
                  .then((_) => formkey.currentState.reset());
            },
            child: Text(
              'Forgot Password ?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );

    // login button
    Widget form = (Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: ButtonTheme(
                height: 48.0,
                child: RaisedButton(
                  onPressed: () => handleSignIn(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  textColor: appColor,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "LOGIN     >",
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: ButtonTheme(
              height: 48.0,
              child: RaisedButton(
                onPressed: () => googleSignIn().whenComplete(() async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();

                  http.Response response = await http.post(
                    url,
                    body: {
                      'username': user.email,
                      'password': user.uid,
                    },
                  );

                  print(response.body);
                  var responseData = jsonDecode(response.body);
                  if (response.statusCode == 200) {
                    if (responseData["success"] == false) {
                      return showErrDialog(context, responseData['msg']);
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      List<String> cartProducts = [];
                      prefs.setBool("isLoggedIn", true);
                      prefs.setString("uid", user.uid);
                      prefs.setString("email", user.email);
                      prefs.setString("name", user.displayName);
                      List c = prefs.getStringList("cartProducts");
                      print('cartProducts');
                      print(c);
                      if (c == null) {
                        print('Hi');
                        prefs.setStringList("cartProducts", cartProducts);
                      }

                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => HomePage(
                                    email: user.email,
                                    name: user.displayName,
                                  )))
                          .then((_) => formkey.currentState.reset());
                    }
                  } else {
                    throw Exception("Error, ${response.statusCode}");
                  }
                }),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                textColor: mainColor,
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage("assets/google.png"),
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () => {},
          //   color: Colors.blue,
          //   icon: Image(
          //     image: AssetImage("assets/google.png"),
          //   ),
          // ),
        ],
      ),
    ));

    // register now field
    Widget registerNow = Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not Registered?  ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RegisterPage()))
                  .then((_) => formkey.currentState.reset());
            },
            child: Text(
              'REGISTER NOW',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );

    // main form
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://image.freepik.com/free-vector/blogger-put-post-message-blog-man-work-with-text-content-management-man-holdings-text-programmer-worker_273625-66.jpg"),
                // "https://image.freepik.com/free-vector/mountain-ridges-vector-illustration-sunrise_105738-948.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Form(
                        key: formkey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log In",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                decoration: InputDecoration(
                                    // hintStyle: TextStyle(
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: 12),
                                    labelText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        // color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child: Icon(Icons.email_outlined),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                validator: emailValidator,
                                onChanged: (val) {
                                  email = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // controller: controller,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                decoration: InputDecoration(
                                    // hintStyle: TextStyle(
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: 12),
                                    labelText: "Password",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        // color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child: Icon(Icons.lock_outline_rounded),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                validator: passwordValidator,
                                onChanged: (val) {
                                  password = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 12.0)),
                            forgotPassword,
                            Padding(padding: EdgeInsets.only(bottom: 12.0)),
                            form,
                            Padding(padding: EdgeInsets.only(bottom: 36.0)),
                            registerNow,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
