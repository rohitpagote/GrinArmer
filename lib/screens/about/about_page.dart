import 'dart:convert';

import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/base/custom_loader.dart';
import 'package:distributer_application/screens/about/privacyPolicy_page.dart';
import 'package:distributer_application/screens/about/tandc_page.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:http/http.dart' as http;

class AboutPage extends StatelessWidget {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();

  Future getAboutSection() async {
    http.Response response = await http
        .get('https://betasources.in/projects/grin-armer//get-app-details');

    print(jsonDecode(response.body)['why']);
    print(jsonDecode(response.body)['why'].length);
    return jsonDecode(response.body);
  }

  final TextStyle style = TextStyle(fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAboutSection(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
            body: ListView(
              children: [
                //why buy from us
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    right: 8.0,
                    left: 8.0,
                  ),
                  child: ExpansionTileCard(
                    key: cardA,
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.message_outlined,
                        color: Colors.grey[700],
                      ),
                    ),
                    title: Text(
                      'Why buy from us?',
                      style: style,
                    ),
                    elevation: 1.0,
                    baseColor: white,
                    children: [
                      Divider(
                        height: 1.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                              ),
                              for (var i = 0;
                                  i < snapshot.data['why'].length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    (i + 1).toString() +
                                        '. ' +
                                        snapshot.data['why'][i],
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                //about us
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                  ),
                  child: ExpansionTileCard(
                    key: cardB,
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.contact_page_outlined,
                        color: Colors.grey[700],
                      ),
                    ),
                    title: Text(
                      'About Us',
                      style: style,
                    ),
                    elevation: 1.0,
                    baseColor: white,
                    children: [
                      Divider(
                        height: 1.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(snapshot.data['about']),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                //contact us
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                  ),
                  child: ExpansionTileCard(
                    key: cardC,
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.contact_support_outlined,
                        color: Colors.grey[700],
                      ),
                    ),
                    title: Text(
                      'Contact Us',
                      style: style,
                    ),
                    elevation: 1.0,
                    baseColor: white,
                    children: [
                      Divider(
                        height: 1.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(snapshot.data['contact']),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                //privacy policy
                Padding(
                  padding: EdgeInsets.only(right: 12.0, left: 12.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.description_outlined,
                        color: Colors.grey[700],
                      ),
                    ),
                    title: Text(
                      'Privacy Policy',
                      style: style,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PrivacyPolicyPage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                //terms and conditions
                Padding(
                  padding: EdgeInsets.only(right: 12.0, left: 12.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.dehaze_rounded,
                        color: Colors.grey[700],
                      ),
                    ),
                    title: Text(
                      'Terms and Conditions',
                      style: style,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => TermsAndConditionsPage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Divider(
                    height: 1.0,
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: CustomLoader(),
        );
      },
    );
  }
}
