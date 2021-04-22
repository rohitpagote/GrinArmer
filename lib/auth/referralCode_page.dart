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

class ReferralCodePage extends StatefulWidget {
  final String email;
  final String name;

  ReferralCodePage({Key key, this.email, this.name}) : super(key: key);

  @override
  _ReferralCodePageState createState() => _ReferralCodePageState(email, name);
}

const String url =
    "https://betasources.in/projects/grin-armer/validate-referral";

class _ReferralCodePageState extends State<ReferralCodePage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final String email;
  final String name;

  _ReferralCodePageState(this.email, this.name);

  String referral = ' ';

  // password validator
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: "Password is required"),
    MinLengthValidator(6, errorText: "Minimum 6 characters required"),
  ]);

  // handle sign in onpressed button
  void sendReferral() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();

      http.Response response = await http.post(
        url,
        body: {
          'username': email,
          'referral': referral == null ? '' : referral,
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BasicInfoPage(
                  email: email,
                  name: name,
                ),
              )).then((_) => formkey.currentState.reset());
        }
      } else {
        throw Exception("Error, ${response.statusCode}");
      }
      //login (php) --end--
    }
  }

  Widget build(BuildContext context) {
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
                  onPressed: () => sendReferral(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  textColor: appColor,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "SUBMIT     >",
                  ),
                ),
              ),
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 4.0),
//            child: ButtonTheme(
//              height: 48.0,
//              child: RaisedButton(
//                onPressed: () => googleSignIn().whenComplete(() async {
//                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
//
//                  http.Response response = await http.post(
//                    url,
//                    body: {
//                      'username': user.email,
//                      'password': user.uid,
//                    },
//                  );
//
//                  print(response.body);
//                  var responseData = jsonDecode(response.body);
//                  if (response.statusCode == 200) {
//                    if (responseData["success"] == false) {
//                      return showErrDialog(context, responseData['msg']);
//                    } else {
//                      SharedPreferences prefs =
//                      await SharedPreferences.getInstance();
//                      List<String> cartProducts = [];
//                      prefs.setBool("isLoggedIn", true);
//                      prefs.setString("uid", user.uid);
//                      prefs.setString("email", user.email);
//                      prefs.setString("name", user.displayName);
//                      List c = prefs.getStringList("cartProducts");
//                      print('cartProducts');
//                      print(c);
//                      if (c == null) {
//                        print('Hi');
//                        prefs.setStringList("cartProducts", cartProducts);
//                      }
//
//                      Navigator.of(context)
//                          .pushReplacement(MaterialPageRoute(
//                          builder: (context) => HomePage(
//                            email: user.email,
//                            name: user.displayName,
//                          )))
//                          .then((_) => formkey.currentState.reset());
//                    }
//                  } else {
//                    throw Exception("Error, ${response.statusCode}");
//                  }
//                }),
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30.0)),
//                textColor: mainColor,
//                color: Colors.white,
//                padding: const EdgeInsets.all(8.0),
//                child: Image(
//                  image: AssetImage("assets/google.png"),
//                ),
//              ),
//            ),
//          ),
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
                              "Referral Code",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
//                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text:
                                        "If you are a salesman then please enter ",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: "REFERRAL CODE.",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                initialValue: email,
                                readOnly: true,
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
                                      data: IconThemeData(color: Colors.black),
                                      child: Icon(Icons.email_outlined),
                                    ),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 10),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
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
                                    labelText: "Referral Code",
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
                                        child: Icon(
                                            Icons.qr_code_scanner_outlined),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
//                                validator: passwordValidator,
                                onChanged: (val) {
                                  referral = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            form,
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
