import 'dart:io';

import 'package:distributer_application/auth/basicInfo_page.dart';
import 'package:distributer_application/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:distributer_application/auth/login_page.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'showErrDialog.dart';

const String url =
    "https://betasources.in/projects/grin-armer/mobile-user-register";

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String password;
  String email;
  String name;
  List<String> cartProducts = [];

  final databaseReference = Firestore.instance;

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

  // name validator
  final nameValidator = MultiValidator([
    RequiredValidator(errorText: "Name is required"),
  ]);

  // handle sign up onpressed button
  void handleSignUp() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();

      // signUp(email.trim(), password, context).then((value) async {
      //   if (value != null) {
      //     await databaseReference
      //         .collection("users")
      //         .document()
      //         .setData({'name': name, 'email': email});
      //   }
      // });

      //register php (--start--)
      http.Response response = await http.post(
        url,
        body: {
          'name': name,
          'username': email,
          'password': password,
        },
      );

      print("response is");
      print(response.statusCode);
      print(response.body);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData["success"] == 'false') {
          return showErrDialog(context, "Error");
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BasicInfoPage(
                  email: email,
                  name: responseData['name'],
                ),
              )).then(
            (_) => formkey.currentState.reset(),
          );
        }
      } else {
        throw Exception("Error, ${response.statusCode}");
      }
      //register php (--end--)
    }
  }

  // register now field
  @override
  Widget build(BuildContext context) {
    Widget alreadyHaveAccount = Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LoginPage()))
                  .then((_) => formkey.currentState.reset());
            },
            child: Text(
              'I already have an Account',
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
                // "https://image.freepik.com/free-vector/cute-astronaut-ice-cream-cone-cartoon-vector-icon-illustration-science-food-icon-concept-isolated-vector-flat-cartoon-styl_138676-2507.jpg"),
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
              child: Container(
                child: Form(
                  key: formkey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create an Account",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.0,
                          ),
                          decoration: InputDecoration(
                              labelText: "Full Name",
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
                                  child: Icon(Icons.person_outline_rounded),
                                ),
                                padding: EdgeInsets.only(left: 20, right: 10),
                              )),
                          validator: nameValidator,
                          onChanged: (val) {
                            name = val;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.0,
                          ),
                          decoration: InputDecoration(
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
                                padding: EdgeInsets.only(left: 20, right: 10),
                              )),
                          validator: emailValidator,
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                      ),
                      // Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      // input(Icon(Icons.phone_android_rounded), "Mobile Number",
                      //     _mobileNumberController, false),
                      Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          // controller: controller,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.0,
                          ),
                          decoration: InputDecoration(
                              hintText: "Password",
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
                                  child: Icon(Icons.lock_outline_rounded),
                                ),
                                padding: EdgeInsets.only(left: 20, right: 10),
                              )),
                          validator: passwordValidator,
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: ButtonTheme(
                                  height: 48.0,
                                  child: RaisedButton(
                                    onPressed: () => handleSignUp(),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    textColor: appColor,
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      "CREATE     >",
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
                                  onPressed: () =>
                                      googleSignIn().whenComplete(() async {
                                    FirebaseUser user = await FirebaseAuth
                                        .instance
                                        .currentUser();

                                    print(user.displayName);
                                    print(user.email);
                                    print(user.uid);

                                    http.Response response = await http.post(
                                      url,
                                      body: {
                                        'name': user.displayName,
                                        'username': user.email,
                                        'password': user.uid,
                                      },
                                    );

                                    print(response.body);
                                    var responseData =
                                        jsonDecode(response.body);
                                    if (response.statusCode == 200) {
                                      if (responseData["success"] == false) {
                                        return showErrDialog(
                                            context, responseData['msg']);
                                      } else {
                                        Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BasicInfoPage(
                                                    email: user.email,
                                                    name: user.displayName,
                                                  ),
                                                ))
                                            .then((_) =>
                                                formkey.currentState.reset());
                                      }
                                    } else {
                                      throw Exception(
                                          "Error, ${response.statusCode}");
                                    }
                                  }),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  textColor: mainColor,
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                    image: AssetImage("assets/google.png"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //form ends
                      Padding(padding: EdgeInsets.only(bottom: 36.0)),
                      alreadyHaveAccount,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 35,
          left: 5,
          child: IconButton(
            color: appColor,
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ));
  }
}
