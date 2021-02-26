import 'package:distributer_application/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:distributer_application/auth/register_page.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/home/home_page.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

// password reset dialog
showPasswordResetEmailDialog(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
  return Alert(
    context: context,
    style: AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
      alertAlignment: Alignment.center,
    ),
    type: AlertType.success,
    title: "Email sent",
    content: Text("Email is send for password reset",
        style: TextStyle(
          fontSize: 12.0,
        )),
    // desc: err,
    buttons: [
      DialogButton(
        border: Border.all(width: 1.0),
        color: Colors.transparent,
        child: Text(
          "Move to LOGIN",
          style: TextStyle(color: mainColor, fontSize: 12),
        ),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginPage())),
        width: 120,
      )
    ],
  ).show();
}

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String email;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // handle password reset onpresses buton
  void handleResetPassword() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      sendPasswordWithResetEmail(email, context).then((value) async {
        if (value == 1) {
          showPasswordResetEmailDialog(context);
        }
      });
    }
  }

  // email validator
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Invalid email address"),
  ]);

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => handleResetPassword(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  textColor: appColor,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "RESET     >",
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

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isLoggedIn", true);
                  prefs.setString("uid", user.uid);
                  prefs.setString("email", user.email);
                  prefs.setString("name", user.displayName);
                  print(user.email);

                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(
                              email: user.email, name: user.displayName)))
                      .then((_) => formkey.currentState.reset());
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
        ],
      ),
    ));

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
                  .push(MaterialPageRoute(builder: (_) => RegisterPage()));
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
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Form(
                        key: formkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Reset Password",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                obscureText: false,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 0.8,
                                ),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                    hintText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        // color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 10,
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
