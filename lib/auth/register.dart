import 'package:distributer_application/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:distributer_application/auth/login_page.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'auth_page.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  // TextEditingController _passwordController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _mobileNumberController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String password;
  String email;
  String name;

  // Widget form = ();

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Invalid email address"),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: "Password is required"),
    MinLengthValidator(6, errorText: "Minimum 6 characters required"),
  ]);

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: "Name is required"),
  ]);

  Widget forgotPassword = Padding(
    padding: const EdgeInsets.only(right: 24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
          child: Text(
            'Forgot Password ?',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );

  Widget input(
    Icon icon,
    String hint,
    String controller,
    bool obsecure,
    MultiValidator validatorType,
  ) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        // controller: controller,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 16,
          height: 0.8,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            hintText: hint,
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
                data: IconThemeData(color: Colors.black),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 20, right: 10),
            )),
        validator: validatorType,
        onChanged: (val) {
          controller = val;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget registerNow = Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LoginPage()));
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

    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://image.freepik.com/free-vector/blogger-put-post-message-blog-man-work-with-text-content-management-man-holdings-text-programmer-worker_273625-66.jpg"),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Spacer(),
                      Text(
                        "Create an Account",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      input(Icon(Icons.person_outlined), "Full Name", name,
                          false, nameValidator),
                      Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      input(Icon(Icons.email_outlined), "Email", email, false,
                          emailValidator),
                      // Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      // input(Icon(Icons.phone_android_rounded), "Mobile Number",
                      //     _mobileNumberController, false),
                      Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      input(Icon(Icons.lock_outline_rounded), "Password",
                          password, true, passwordValidator),
                      Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      //form starts
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ButtonTheme(
                                height: 48.0,
                                child: RaisedButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  textColor: Colors.blue,
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                    "CREATE     >",
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () =>
                                    googleSignIn().whenComplete(() async {
                                      FirebaseUser user = await FirebaseAuth
                                          .instance
                                          .currentUser();

                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                    email: email,
                                                    name: user.displayName,
                                                  )));
                                    }),
                                color: Colors.blue,
                                icon: Image(
                                  image: AssetImage("assets/google.png"),
                                )),
                            IconButton(
                                onPressed: () {},
                                color: Colors.red,
                                icon: Image(
                                  image: AssetImage("assets/facebook.png"),
                                ))
                          ],
                        ),
                      ),
                      //form ends
                      Padding(padding: EdgeInsets.only(bottom: 36.0)),
                      registerNow,
                      // Spacer(),
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
            color: mainColor,
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
