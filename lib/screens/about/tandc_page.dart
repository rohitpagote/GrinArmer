import 'dart:convert';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/base/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TermsAndConditionsPage extends StatelessWidget {
  // Future getTermsAndConditions() async {
  //   http.Response response = await http
  //       .get('https://betasources.in/projects/grin-armer//get-app-details');

  //   print(response.body);
  //   return jsonDecode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Image.asset(
          'assets/GrinArmerLogo.png',
          height: 55.0,
        ),
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: null,
          child: Divider(height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TERMS & CONDITIONS',
                  style: TextStyle(
                    color: appColor,
                    fontSize: 16.0,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                  bottom: 8.0,
                )),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
