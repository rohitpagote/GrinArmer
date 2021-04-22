import 'dart:convert';

import 'package:distributer_application/auth/showErrDialog.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/base/custom_loader.dart';
import 'package:distributer_application/base/zoomingImg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SalesmansOrder extends StatefulWidget {
  @override
  _SalesmansOrderState createState() => _SalesmansOrderState();
}

class _SalesmansOrderState extends State<SalesmansOrder> {
  getSalesmanEnquiry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role');
    String referral = prefs.getString('referral');

    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/get-salesman-enquiry',
        body: {
          'role': role,
          'referral': referral,
        });

    print(response.statusCode);
    print(response.body);
    var responseBody = jsonDecode(response.body);
    // print(responseBody[0]['cart']);
    // if (responseBody['success'] == true) {
    //   return responseBody;
    // } else {
    //   // showErrDialog(context, responseBody['msg']);
    //   print(responseBody['msg']);
    // }
    return responseBody;
  }

  @override
  void initState() {
    super.initState();
  }

  void respondToCart(cartId, confirmStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/respond-to-cart',
        body: {
          'cart_id': cartId.toString(),
          'username': email,
          'confirm': confirmStatus.toString(),
        });

    print(response.statusCode);
    print(response.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSalesmanEnquiry(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appColor,
              elevation: 2.0,
              centerTitle: true,
              title: Text(
                "Salesmans Order",
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
                            child: Text('Sorry, No order to show.'),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
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
                                  // color: black,
                                  padding: EdgeInsets.all(12.0),
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
                                                    text: 'Name : ',
                                                    style: TextStyle(
                                                        color: appColor)),
                                                TextSpan(
                                                  text: snapshot.data[index1]
                                                      ['name'],
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
                                                    text: 'Email : ',
                                                    style: TextStyle(
                                                        color: appColor)),
                                                TextSpan(
                                                  text: snapshot.data[index1]
                                                      ['username'],
                                                  style: TextStyle(
                                                    color: appColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SizedBox(
                                          height: 4,
                                          child: Container(
                                            color: Color(0xFFf5f6f7),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: ListView.builder(
                                          primary: false,
                                          itemCount: snapshot
                                              .data[index1]['cart'].length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context2, index2) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  'Cart ID : ',
                                                              style: TextStyle(
                                                                  color:
                                                                      appColor)),
                                                          TextSpan(
                                                            text: snapshot.data[
                                                                            index1]
                                                                        ['cart']
                                                                    [index2]
                                                                ['cart_id'],
                                                            style: TextStyle(
                                                              color: appColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                              text:
                                                                  'Ordered On : ',
                                                              style: TextStyle(
                                                                  color:
                                                                      appColor)),
                                                          TextSpan(
                                                            text: snapshot.data[
                                                                            index1]
                                                                        ['cart']
                                                                    [index2]
                                                                ['ordered_on'],
                                                            style: TextStyle(
                                                              color: appColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: SizedBox(
                                                    height: 250,
                                                    child: ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount: snapshot
                                                          .data[index1]['cart']
                                                              [index2]
                                                              ['products']
                                                          .length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context3, index3) =>
                                                              Card(
                                                        child: SizedBox(
                                                          width:
                                                              170, // put 190 for landscape
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ZoomingImg(
                                                                            img:
                                                                                snapshot.data[index1]['cart'][index2]['products'][index3]['images'][0],
                                                                          ),
                                                                        ));
                                                                  },
                                                                  child:
                                                                      GridTile(
                                                                          child:
                                                                              ClipRRect(
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                4.0),
                                                                        topRight:
                                                                            Radius.circular(4.0)),
                                                                    child: Image
                                                                        .network(
                                                                      snapshot.data[index1]['cart'][index2]['products']
                                                                              [
                                                                              index3]
                                                                          [
                                                                          'images'][0],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  )),
                                                                ),
                                                              ),
                                                              Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0,
                                                                      right:
                                                                          8.0,
                                                                      left:
                                                                          8.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Divider(
                                                                        color:
                                                                            appColor,
                                                                        // height: 20,
                                                                        thickness:
                                                                            1,
                                                                      ),
                                                                      Text(
                                                                        snapshot.data[index1]['cart'][index2]['products'][index3]
                                                                            [
                                                                            'product_name'],
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.fade,
                                                                        softWrap:
                                                                            false,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              12.0,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(2.0),
                                                                      ),
                                                                      Text(
                                                                        "Weight : " +
                                                                            snapshot.data[index1]['cart'][index2]['products'][index3]['weight'],
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.fade,
                                                                        softWrap:
                                                                            false,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              12.0,
                                                                        ),
                                                                      ),
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    FlatButton(
                                                      color: Colors.blue,
                                                      textColor: Colors.white,
                                                      child: Text(
                                                        'Accept',
                                                      ),
                                                      onPressed: () {
                                                        respondToCart(
                                                            snapshot.data[index1]
                                                                        ['cart']
                                                                    [index2]
                                                                ['cart_id'],
                                                            1);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      color: Colors.red,
                                                      textColor: Colors.white,
                                                      child: Text(
                                                        'Reject',
                                                      ),
                                                      onPressed: () {
                                                        respondToCart(
                                                            snapshot.data[index1]
                                                                        ['cart']
                                                                    [index2]
                                                                ['cart_id'],
                                                            -1);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    height: 4,
                                                    child: Container(
                                                      color: Color(0xFFf5f6f7),
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
                                ),
                                // Container(
                                //   height: 285.0 *
                                //       snapshot.data[index1]['cart'].length,
                                //   child: ListView.builder(
                                //     itemCount:
                                //         snapshot.data[index1]['cart'].length,
                                //     itemBuilder: (context2, index2) {
                                //       return Column(
                                //         children: [
                                //           Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               Text.rich(
                                //                 TextSpan(
                                //                   children: [
                                //                     TextSpan(
                                //                         text: 'Cart ID : ',
                                //                         style: TextStyle(
                                //                             color: appColor)),
                                //                     TextSpan(
                                //                       text: snapshot
                                //                                   .data[index1]
                                //                               ['cart'][index2]
                                //                           ['cart_id'],
                                //                       style: TextStyle(
                                //                         color: appColor,
                                //                         fontWeight:
                                //                             FontWeight.bold,
                                //                         fontSize: 12.0,
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //               Text.rich(
                                //                 TextSpan(
                                //                   children: [
                                //                     TextSpan(
                                //                         text: 'Ordered On : ',
                                //                         style: TextStyle(
                                //                             color: appColor)),
                                //                     TextSpan(
                                //                       text: snapshot
                                //                                   .data[index1]
                                //                               ['cart'][index2]
                                //                           ['ordered_on'],
                                //                       style: TextStyle(
                                //                         color: appColor,
                                //                         fontWeight:
                                //                             FontWeight.bold,
                                //                         fontSize: 12.0,
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //           Container(
                                //             child: SizedBox(
                                //               height: 250,
                                //               child: ListView.builder(
                                //                 physics:
                                //                     BouncingScrollPhysics(),
                                //                 itemCount: snapshot
                                //                     .data[index1]['cart']
                                //                         [index2]['products']
                                //                     .length,
                                //                 scrollDirection:
                                //                     Axis.horizontal,
                                //                 itemBuilder:
                                //                     (context3, index3) => Card(
                                //                   child: SizedBox(
                                //                     width:
                                //                         170, // put 190 for landscape
                                //                     child: Column(
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment
                                //                               .spaceBetween,
                                //                       children: [
                                //                         Expanded(
                                //                           child:
                                //                               GestureDetector(
                                //                             onTap: () {
                                //                               Navigator.push(
                                //                                   context,
                                //                                   MaterialPageRoute(
                                //                                     builder:
                                //                                         (context) =>
                                //                                             ZoomingImg(
                                //                                       img: snapshot.data[index1]['cart'][index2]['products']
                                //                                               [
                                //                                               index3]
                                //                                           [
                                //                                           'images'][0],
                                //                                     ),
                                //                                   ));
                                //                             },
                                //                             child: GridTile(
                                //                                 child:
                                //                                     ClipRRect(
                                //                               borderRadius: BorderRadius.only(
                                //                                   topLeft: Radius
                                //                                       .circular(
                                //                                           4.0),
                                //                                   topRight: Radius
                                //                                       .circular(
                                //                                           4.0)),
                                //                               child:
                                //                                   Image.network(
                                //                                 snapshot.data[index1]['cart']
                                //                                             [
                                //                                             index2]
                                //                                         [
                                //                                         'products'][index3]
                                //                                     [
                                //                                     'images'][0],
                                //                                 fit: BoxFit
                                //                                     .cover,
                                //                               ),
                                //                             )),
                                //                           ),
                                //                         ),
                                //                         Center(
                                //                           child: Padding(
                                //                             padding:
                                //                                 const EdgeInsets
                                //                                         .only(
                                //                                     bottom: 8.0,
                                //                                     right: 8.0,
                                //                                     left: 8.0),
                                //                             child: Column(
                                //                               children: [
                                //                                 Divider(
                                //                                   color:
                                //                                       appColor,
                                //                                   // height: 20,
                                //                                   thickness: 1,
                                //                                 ),
                                //                                 Text(
                                //                                   snapshot.data[index1]['cart'][index2]
                                //                                               [
                                //                                               'products']
                                //                                           [
                                //                                           index3]
                                //                                       [
                                //                                       'product_name'],
                                //                                   maxLines: 1,
                                //                                   overflow:
                                //                                       TextOverflow
                                //                                           .fade,
                                //                                   softWrap:
                                //                                       false,
                                //                                   style:
                                //                                       TextStyle(
                                //                                     color: Colors
                                //                                         .black,
                                //                                     fontWeight:
                                //                                         FontWeight
                                //                                             .bold,
                                //                                     fontSize:
                                //                                         12.0,
                                //                                   ),
                                //                                 ),
                                //                                 Padding(
                                //                                   padding:
                                //                                       EdgeInsets
                                //                                           .all(
                                //                                               2.0),
                                //                                 ),
                                //                                 Text(
                                //                                   "Weight : " +
                                //                                       snapshot.data[index1]['cart'][index2]['products']
                                //                                               [
                                //                                               index3]
                                //                                           [
                                //                                           'weight'],
                                //                                   maxLines: 1,
                                //                                   overflow:
                                //                                       TextOverflow
                                //                                           .fade,
                                //                                   softWrap:
                                //                                       false,
                                //                                   style:
                                //                                       TextStyle(
                                //                                     color: Colors
                                //                                         .black,
                                //                                     fontWeight:
                                //                                         FontWeight
                                //                                             .bold,
                                //                                     fontSize:
                                //                                         12.0,
                                //                                   ),
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //           Padding(
                                //             padding: const EdgeInsets.all(4.0),
                                //             child: SizedBox(
                                //               height: 4,
                                //               child: Container(
                                //                 color: Color(0xFFf5f6f7),
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       );
                                //     },
                                //   ),
                                // ),
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

// SizedBox(
//                                     height: 250,
//                                     child: ListView.builder(
//                                       physics: BouncingScrollPhysics(),
//                                       itemCount:
//                                           snapshot.data[index1]['cart'].length,
//                                       scrollDirection: Axis.horizontal,
//                                       itemBuilder: (context2, index2) => Card(
//                                         child: SizedBox(
//                                           width: 170, // put 190 for landscape
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               ZoomingImg(
//                                                             img: snapshot.data[index1]
//                                                                             [
//                                                                             'cart']
//                                                                         [
//                                                                         index2]
//                                                                     ['products']
//                                                                 [
//                                                                 0]['images'][0],
//                                                           ),
//                                                         ));
//                                                   },
//                                                   child: GridTile(
//                                                       child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.only(
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     4.0),
//                                                             topRight: Radius
//                                                                 .circular(4.0)),
//                                                     child: Image.network(
//                                                       snapshot.data[index1]
//                                                                       ['cart']
//                                                                   [index2]
//                                                               ['products'][0]
//                                                           ['images'][0],
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   )),
//                                                 ),
//                                               ),
//                                               Center(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           bottom: 8.0,
//                                                           right: 8.0,
//                                                           left: 8.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Divider(
//                                                         color: appColor,
//                                                         // height: 20,
//                                                         thickness: 1,
//                                                       ),
//                                                       Text(
//                                                         snapshot.data[index1]
//                                                                         ['cart']
//                                                                     [index2]
//                                                                 ['products'][index3]
//                                                             ['product_name'],
//                                                         maxLines: 1,
//                                                         overflow:
//                                                             TextOverflow.fade,
//                                                         softWrap: false,
//                                                         style: TextStyle(
//                                                           color: Colors.black,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 12.0,
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.all(2.0),
//                                                       ),
//                                                       Text(
//                                                         "Weight : " +
//                                                             snapshot.data[index1]
//                                                                             [
//                                                                             'cart']
//                                                                         [
//                                                                         index2]
//                                                                     ['products']
//                                                                 [0]['weight'],
//                                                         maxLines: 1,
//                                                         overflow:
//                                                             TextOverflow.fade,
//                                                         softWrap: false,
//                                                         style: TextStyle(
//                                                           color: Colors.black,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 12.0,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
