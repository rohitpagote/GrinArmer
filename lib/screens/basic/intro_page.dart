import 'dart:convert';

import 'package:distributer_application/auth/login_page.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:http/http.dart' as http;

const String url = "https://betasources.in/projects/grin-armer/get-all-intros";

bool getResponse = false;

class IntroPage extends StatelessWidget {
  Future<List<dynamic>> fetchIntros() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      getResponse = true;
      return jsonDecode(response.body);
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  final pages = <PageViewModel>[];
  var i = 0;

  final defaultPage = [
    PageViewModel(
      pageColor: Colors.white,
      bubbleBackgroundColor: appColor,
      bubble: Image.asset('assets/mushroom.png'),
      body: Text(
        'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
      ),
      title: Text(
        'Mashrooms',
      ),
      titleTextStyle: TextStyle(color: Colors.black),
      bodyTextStyle: TextStyle(color: Colors.black),
      mainImage: Image.network(
          "https://image.freepik.com/free-vector/blue-mushroom-illustration_6229-179.jpg"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) => FutureBuilder(
            future: fetchIntros(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                while (i < snapshot.data.length) {
                  pages.add(
                    PageViewModel(
                      pageColor: Colors.white,
                      bubbleBackgroundColor: appColor,
                      bubble: Image.asset('assets/mushroom.png'),
                      body: Text(snapshot.data[i]["name"]),
                      title: Text(
                        snapshot.data[i]["name"],
                        style: TextStyle(fontSize: 36.0),
                      ),
                      mainImage: Image.network(
                        snapshot.data[i]["path"],
                        fit: BoxFit.contain,
                      ),
                      titleTextStyle: TextStyle(color: Colors.black),
                      bodyTextStyle: TextStyle(color: Colors.black),
                    ),
                  );
                  i++;
                }
                return IntroViewsFlutter(
                  getResponse == true ? pages : defaultPage,
                  onTapSkipButton: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  onTapDoneButton: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  pageButtonTextStyles: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
