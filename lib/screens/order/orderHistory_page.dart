import 'dart:convert';

import 'package:distributer_application/auth/showErrDialog.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/base/custom_loader.dart';
import 'package:distributer_application/base/zoomingImg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:distributer_application/home/home_page.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  getOrderHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/get-order-status',
        body: {
          'username': email,
        });

    print(response.body);
    return jsonDecode(response.body);
  }

  sendDelieveryConfirmation(cartId) async {
    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/delivery-status',
        body: {
          'id': cartId,
        });

    print(cartId);
    print(response.statusCode);
    print(response.body);
    var responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      showSuccessDialog(context, responseBody['msg']);
      setState(() {});
    } else {
      showErrDialog(context, responseBody['msg']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOrderHistory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
              children: [
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Orders : ' + snapshot.data.length.toString(),
                            style: TextStyle(
                              color: appColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Please press YES if the order is delivered',
                            style: TextStyle(
                              color: appColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 8.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                snapshot.data.length == 0
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                                'Sorry, you haven\'t purchased our any product till now.'),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context1, index1) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                  child: Container(
                                    color: Color(0xFFf5f6f7),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(12.0),
                                  // height: 50.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: 'Order Date : ',
                                                    style: TextStyle(
                                                        color: appColor)),
                                                TextSpan(
                                                  text: snapshot.data[index1]
                                                      ['order_date'],
                                                  style: TextStyle(
                                                    color: appColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: 'Status : ',
                                                    style: TextStyle(
                                                        color: appColor)),
                                                TextSpan(
                                                  text: snapshot.data[index1]
                                                      ['status'],
                                                  style: TextStyle(
                                                    color: snapshot.data[index1]
                                                                ['status'] ==
                                                            'Pending'
                                                        ? Colors.red
                                                        : Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      snapshot.data[index1]['confirm'] == '1' &&
                                              snapshot.data[index1]
                                                      ['delivery'] ==
                                                  '0'
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              'Is your order delivered? ',
                                                          style: TextStyle(
                                                              color: appColor)),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // FlatButton(
                                                    //   child: Text(
                                                    //     'YES',
                                                    //     style: TextStyle(
                                                    //       color: Colors.blue,
                                                    //     ),
                                                    //   ),
                                                    //   onPressed: () {},
                                                    // ),
                                                    OutlineButton(
                                                      child: Text(
                                                        'YES',
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        sendDelieveryConfirmation(
                                                            snapshot.data[
                                                                index1]['id']);
                                                      },
                                                      borderSide: BorderSide(
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : SizedBox(
                                              height: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 8.0,
                                  ),
                                  child: SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot
                                          .data[index1]['products'].length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context2, index2) => Card(
                                        child: SizedBox(
                                          width: 170, // put 190 for landscape
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ZoomingImg(
                                                            img: snapshot.data[
                                                                        index1]
                                                                    ['products']
                                                                [
                                                                index2]['images'][0],
                                                          ),
                                                        ));
                                                  },
                                                  child: GridTile(
                                                      child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight: Radius
                                                                .circular(4.0)),
                                                    child: Image.network(
                                                      snapshot.data[index1]
                                                              ['products']
                                                          [index2]['images'][0],
                                                      fit: BoxFit.cover,
                                                    ),
//                                                      Text("R"),
                                                  )),
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0,
                                                          right: 8.0,
                                                          left: 8.0),
                                                  child: Column(
                                                    children: [
                                                      Divider(
                                                        color: appColor,
                                                        // height: 20,
                                                        thickness: 1,
                                                      ),
                                                      Text(
                                                        snapshot.data[index1]
                                                                    ['products']
                                                                [index2]
                                                            ['product_name'],
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(2.0),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            "Wt : " +
                                                                snapshot.data[index1]
                                                                            [
                                                                            'products']
                                                                        [index2]
                                                                    ['weight'],
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Qty : " +
                                                                snapshot.data[
                                                                            index1]
                                                                        [
                                                                        'products']
                                                                    [
                                                                    index2]['qty'],
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Server Error'),
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
