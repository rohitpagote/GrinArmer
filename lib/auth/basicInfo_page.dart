import 'dart:convert';
import 'dart:io';
import 'package:distributer_application/auth/showErrDialog.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/base/custom_loader.dart';
import 'package:distributer_application/home/home_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicInfoPage extends StatefulWidget {
  final String email;
  String name;

  BasicInfoPage({Key key, @required this.email, @required this.name})
      : super(key: key);

  @override
  _BasicInfoPageState createState() => _BasicInfoPageState(email, name);
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String email;
  String name;

  _BasicInfoPageState(this.email, this.name);

  static const String addDetailsUrl =
      "https://betasources.in/projects/grin-armer/add-user-address";

  static const String getDetailsUrl =
      "https://betasources.in/projects/grin-armer/get-user-address";

  static const String getCountryUrl =
      "https://betasources.in/projects/grin-armer/get-all-countries";

  String phoneNo,
      gst,
      shopName,
      country,
      state,
      city,
      addressLine1,
      addressLine2,
      pincode;

  String deviceName;
  String deviceVersion;
  String identifier;

  //name validator
  final nameValidator = MultiValidator([
    RequiredValidator(errorText: "Name is required"),
  ]);

  //phone no validator
  final phoneNoValidator = MultiValidator([
    LengthRangeValidator(min: 10, max: 10, errorText: "Length must be 10 only"),
    // MinLengthValidator(10, errorText: "Length must be 10 only")
  ]);

  //shop name validator
  final shopNameValidator = MultiValidator([
    RequiredValidator(errorText: "Shop Name is required"),
  ]);

  //shop name validator
  final addressLine1Validator = MultiValidator([
    RequiredValidator(errorText: "Address Line 1 is required"),
  ]);

  //pincode validator
  final pincodeValidator = MultiValidator([
    LengthRangeValidator(min: 6, max: 6, errorText: "Length must be 6 only"),
  ]);

  //country validator
  final countryValidator = MultiValidator([
    RequiredValidator(errorText: "Country is required"),
  ]);

  //name validator
  final stateValidator = MultiValidator([
    RequiredValidator(errorText: "State is required"),
  ]);

  //city validator
  final cityValidator = MultiValidator([
    RequiredValidator(errorText: "City is required"),
  ]);

  Future<Map<String, dynamic>> fetchUserDetails() async {
    http.Response response = await http.post(getDetailsUrl, body: {
      'username': email,
    });

    var responseData = jsonDecode(response.body);
    name = responseData['name'];
//    phoneNo = responseData['phone'];
//    gst = responseData['gst'];
//    shopName = responseData['shopName'];
//    country = responseData['country'];
//    state = responseData['state'];
//    city = responseData['city'];
//    addressLine1 = responseData['addressLine1'];
//    addressLine2 = responseData['addressLine2'];
//    pincode = responseData['pincode'];
    phoneNo = responseData['phone'];
    gst = responseData['gst'];
    shopName = responseData['shopName'];
    country = responseData['country'];
    state = responseData['state'];
    city = responseData['city'];
    addressLine1 = responseData['addressLine1'];
    addressLine2 = responseData['addressLine2'];
    pincode = responseData['pincode'];
    return jsonDecode(response.body);
  }

  //for getting deviceid
  Future<List<String>> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return [deviceName, deviceVersion, identifier];
  }

  //get countries
  // List<String> countries = [];
  Future<List<dynamic>> getCountries() async {
    http.Response response = await http.get(getCountryUrl);

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<String> countries = [];
      for (int i = 0; i < responseBody.length; i++) {
        countries.add(responseBody[i]['name']);
      }
      // print(countries);
      return countries;
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  //get states
  List<String> states = [];

  getStates(country) async {
    // states.clear();
    http.Response response = await http.get(
        "https://betasources.in/projects/grin-armer/get-state?country=$country");

    if (response.statusCode == 200) {
      print(country);
      states.clear();
      List<dynamic> responseBody = jsonDecode(response.body);
      for (int i = 0; i < responseBody.length; i++) {
        states.add(responseBody[i]['name']);
      }
      // print('states are');
      // print(states);
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  //get states
  List<String> cities = [];

  getCities(state) async {
    http.Response response = await http.get(
        "https://betasources.in/projects/grin-armer/get-city?state=$state");

    if (response.statusCode == 200) {
      // print(state);
      cities.clear();
      List<dynamic> responseBody = jsonDecode(response.body);
      for (int i = 0; i < responseBody.length; i++) {
        cities.add(responseBody[i]['name']);
      }
      // print('cities are');
      // print(cities);
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  void addUserDetails() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      http.Response response = await http.post(
        addDetailsUrl,
        body: {
          'name': name,
          'username': email,
          'phone': phoneNo,
          'gst': gst,
          'shopName': shopName,
          'country': country,
          'state': state,
          'city': city,
          'addressLine1': addressLine1,
          'addressLine2': addressLine2,
          'pincode': pincode,
          'deviceid': identifier,
        },
      );

      print(response.statusCode);
      print(response.body);

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
//          showSuccessDialog(context, responseData['msg']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("email", email);
          prefs.setString("name", responseData['name']);
          prefs.setStringList("cartProducts", []);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  email: email,
                  name: responseData['name'],
                ),
              )).then((_) => formKey.currentState.reset());
        } else {
          showErrDialog(context, responseData['msg']);
        }
      } else {
        showErrDialog(
            context, 'Details updation failed. Please try again later');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        getDeviceDetails(),
        getCountries(),
        fetchUserDetails(),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          print(deviceName);
          print(deviceVersion);
          print(identifier);
          // name = snapshot.data['name'];
          // phoneNo = snapshot.data['phone'];
          // gst = snapshot.data['gst'];
          // shopName = snapshot.data['shopName'];
          // country = snapshot.data['country'];
          // state = snapshot.data['state'];
          // city = snapshot.data['city'];
          // addressLine1 = snapshot.data['addressLine1'];
          // addressLine2 = snapshot.data['addressLine2'];
          // pincode = snapshot.data['pincode'];

          return Scaffold(
            key: _scaffoldKey,
//            appBar: AppBar(
//              backgroundColor: appColor,
//              elevation: 2.0,
//              centerTitle: true,
//              title: Text(
//                "Account Settings",
//                style: TextStyle(
//                  color: white,
//                ),
//              ),
//              iconTheme: IconThemeData(
//                color: white,
//              ),
//
//              // bottom: PreferredSize(
//              //   child: Container(
//              //     color: white,
//              //     height: 1.5,
//              //   ),
//              //   preferredSize: Size.fromHeight(4.0),
//              // ),
//            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Center(
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //form field start here
                            //full name
                            Container(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Please fill in the basic details.',
                                maxLines: 2,
                                style: TextStyle(
                                  color: appColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                initialValue: snapshot.data[2]['name'],
                                keyboardType: TextInputType.name,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child:
                                            Icon(Icons.person_outline_rounded),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                validator: nameValidator,
                                onChanged: (val) {
                                  name = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //email
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: email,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 1,
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
                                // onChanged: (val) {
                                //   email = val;
                                // },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                initialValue: snapshot.data[2]["phone"],
                                keyboardType: TextInputType.phone,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 10,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                decoration: InputDecoration(
                                    prefix: Text("+91"),
                                    labelText: "Phone Number",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child:
                                            Icon(Icons.phone_android_rounded),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                validator: phoneNoValidator,
                                onChanged: (val) {
                                  phoneNo = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //gst
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                initialValue: snapshot.data[2]["gst"],
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                decoration: InputDecoration(
                                    labelText: "GST (optional)",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child: Icon(
                                            Icons.confirmation_number_outlined),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                // validator: passwordValidator,
                                onChanged: (val) {
                                  gst = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //shop name
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                initialValue: snapshot.data[2]["shopName"],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Shop Name",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child:
                                            Icon(Icons.shopping_bag_outlined),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                validator: shopNameValidator,
                                onChanged: (val) {
                                  shopName = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),

                            //country dropdown
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: DropdownSearch<String>(
                                mode: Mode.BOTTOM_SHEET,
                                showSelectedItem: true,
                                items: snapshot.data[1],
                                label: "Country",
                                selectedItem: snapshot.data[2]['country'],
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: countryValidator,
                                showSearchBox: true,
                                onChanged: (val) {
                                  getStates(val);
                                  country = val;
                                },
                                dropdownSearchDecoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: appColor,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: grey,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    child: IconTheme(
                                      data: IconThemeData(color: Colors.black),
                                      child: Icon(Icons.emoji_flags_outlined),
                                    ),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 10),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //country old
                            // Container(
                            //   padding: EdgeInsets.only(left: 20, right: 20),
                            //   child: TextFormField(
                            //     initialValue: snapshot.data[1]["country"],
                            //     keyboardType: TextInputType.name,
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       height: 1.0,
                            //     ),
                            //     decoration: InputDecoration(
                            //         labelText: "Country",
                            //         enabledBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(4),
                            //           borderSide: BorderSide(
                            //             color: appColor,
                            //             width: 1,
                            //           ),
                            //         ),
                            //         focusedBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(4),
                            //           borderSide: BorderSide(
                            //             color: grey,
                            //             width: 1,
                            //           ),
                            //         ),
                            //         prefixIcon: Padding(
                            //           child: IconTheme(
                            //             data: IconThemeData(
                            //                 color: Colors.black),
                            //             child:
                            //                 Icon(Icons.emoji_flags_outlined),
                            //           ),
                            //           padding: EdgeInsets.only(
                            //               left: 20, right: 10),
                            //         )),
                            //     // validator: passwordValidator,
                            //     onChanged: (val) {
                            //       country = val;
                            //     },
                            //   ),
                            // ),
                            // Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //state
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: DropdownSearch<String>(
                                mode: Mode.BOTTOM_SHEET,
                                showSelectedItem: true,
                                items: states,
                                label: "State",
                                selectedItem: snapshot.data[2]['state'],
                                showSearchBox: true,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: stateValidator,
                                onChanged: (val) {
                                  getCities(val);
                                  state = val;
                                },
                                dropdownSearchDecoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: appColor,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: grey,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    child: IconTheme(
                                      data: IconThemeData(color: Colors.black),
                                      child: Icon(Icons.location_city_rounded),
                                    ),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 10),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),

                            // Container(
                            //   padding: EdgeInsets.only(left: 20, right: 20),
                            //   child: TextFormField(
                            //     initialValue: snapshot.data[1]["state"],
                            //     keyboardType: TextInputType.name,
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       height: 1.0,
                            //     ),
                            //     decoration: InputDecoration(
                            //         labelText: "State",
                            //         enabledBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(4),
                            //           borderSide: BorderSide(
                            //             color: appColor,
                            //             width: 1,
                            //           ),
                            //         ),
                            //         focusedBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(4),
                            //           borderSide: BorderSide(
                            //             color: grey,
                            //             width: 1,
                            //           ),
                            //         ),
                            //         prefixIcon: Padding(
                            //           child: IconTheme(
                            //             data: IconThemeData(
                            //                 color: Colors.black),
                            //             child:
                            //                 Icon(Icons.location_city_rounded),
                            //           ),
                            //           padding: EdgeInsets.only(
                            //               left: 20, right: 10),
                            //         )),
                            //     // validator: passwordValidator,
                            //     onChanged: (val) {
                            //       state = val;
                            //     },
                            //   ),
                            // ),
                            // Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //city
                            //state
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: DropdownSearch<String>(
                                mode: Mode.BOTTOM_SHEET,
                                showSelectedItem: true,
                                items: cities,
                                label: "City",
                                selectedItem: snapshot.data[2]['city'],
                                showSearchBox: true,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: cityValidator,
                                onChanged: (val) {
                                  city = val;
                                },
                                dropdownSearchDecoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: appColor,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: grey,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    child: IconTheme(
                                      data: IconThemeData(color: Colors.black),
                                      child: Icon(Icons.house_outlined),
                                    ),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 10),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            // Container(
                            //   padding: EdgeInsets.only(left: 20, right: 20),
                            //   child: TextFormField(
                            //     initialValue: snapshot.data[1]["city"],
                            //     keyboardType: TextInputType.name,
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       height: 1.0,
                            //     ),
                            //     decoration: InputDecoration(
                            //         labelText: "City",
                            //         enabledBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(4),
                            //           borderSide: BorderSide(
                            //             color: appColor,
                            //             width: 1,
                            //           ),
                            //         ),
                            //         focusedBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(4),
                            //           borderSide: BorderSide(
                            //             color: grey,
                            //             width: 1,
                            //           ),
                            //         ),
                            //         prefixIcon: Padding(
                            //           child: IconTheme(
                            //             data: IconThemeData(
                            //                 color: Colors.black),
                            //             child: Icon(Icons.house_rounded),
                            //           ),
                            //           padding: EdgeInsets.only(
                            //               left: 20, right: 10),
                            //         )),
                            //     // validator: passwordValidator,
                            //     onChanged: (val) {
                            //       city = val;
                            //     },
                            //   ),
                            // ),
                            // Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //adress line 1
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                initialValue: snapshot.data[2]["addressLine1"],
                                keyboardType: TextInputType.streetAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Address Line 1",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child: Icon(Icons.add_road_rounded),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                validator: addressLine1Validator,
                                onChanged: (val) {
                                  addressLine1 = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //adress line 2
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                initialValue: snapshot.data[2]["addressLine2"],
                                keyboardType: TextInputType.streetAddress,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Address Line 2 (Optional)",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child: Icon(Icons.add_road_rounded),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                // validator: passwordValidator,
                                onChanged: (val) {
                                  addressLine2 = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 25.0)),
                            //pincode
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                initialValue: snapshot.data[2]['pincode'],
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 6,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Pincode",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: grey,
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: appColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data:
                                            IconThemeData(color: Colors.black),
                                        child: Icon(
                                            Icons.person_pin_circle_outlined),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                    )),
                                validator: pincodeValidator,
                                onChanged: (val) {
                                  pincode = val;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            FlatButton(
                              color: appColor,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(12.0),
                              splashColor: Colors.greenAccent,
                              minWidth: MediaQuery.of(context).size.width - 100,
                              onPressed: () {
                                if (name == '') {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Name is required.'),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 3.0,
                                    backgroundColor: Colors.redAccent,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                  ));
                                }
                                if (phoneNo.length != 10) {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                        'Length of Phone no must be 10 only.'),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 3.0,
                                    backgroundColor: Colors.redAccent,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                  ));
                                }
                                if (shopName == '') {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Shop Name is required.'),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 3.0,
                                    backgroundColor: Colors.redAccent,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                  ));
                                }
                                if (country == '') {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Country is required.'),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 3.0,
                                    backgroundColor: Colors.redAccent,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                  ));
                                }
                                if (state == '') {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('State is required.'),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 3.0,
                                    backgroundColor: Colors.redAccent,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                  ));
                                }
                                if (city == '') {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('City is required.'),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 3.0,
                                    backgroundColor: Colors.redAccent,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                  ));
                                }
                                if (addressLine1 == '') {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content:
                                        Text('Address Line 1 is required.'),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 3.0,
                                    backgroundColor: Colors.redAccent,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                  ));
                                }
                                if (pincode.length != 6) {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                        'Length of Pincode must be 6 only.'),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 3.0,
                                    backgroundColor: Colors.redAccent,
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                  ));
                                }
                                addUserDetails();
                              },
                              child: Text(
                                "SAVE",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Server Error.")),
          );
        } else {
          return Scaffold(
            body: CustomLoader(),
          );
        }
      },
    );
  }
}
