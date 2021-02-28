import 'package:distributer_application/base/color_properties.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {

  doProductManagement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/get-order-status',
        body: {
          'username' : email,
        }
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 2.0,
        centerTitle: true,
        title: Text(
          "Order History",
          style: TextStyle(
            color: white,
          ),
        ),
        iconTheme: IconThemeData(
          color: white,
        ),
      ),
      body: Column(
        
      ),
    );
  }
}
