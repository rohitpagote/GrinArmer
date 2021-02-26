// import 'package:distributer_application/base/color_properties.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// const String url = "https://betasources.in/projects/grin-armer/get-all-banners";

// class AllProductsPage extends StatefulWidget {
//   AllProductsPage(String id, {String id});

//   @override
//   _AllProductsPageState createState() => _AllProductsPageState();
// }

// class _AllProductsPageState extends State<AllProductsPage> {
//   Future<List<dynamic>> fetchProducts() async {
//     http.Response response = await http.get(url);

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Error, ${response.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Products"),
//         ),
//         body: FutureBuilder(
//           future: fetchProducts(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: OrientationBuilder(
//                       builder: (context, orientation) {
//                         return GridView.count(
//                           childAspectRatio: 0.7,
//                           crossAxisCount:
//                               orientation == Orientation.portrait ? 2 : 4,
//                           children:
//                               List.generate(snapshot.data.length, (index) {
//                             return InkWell(
//                               onTap: () {
//                                 print("tapped{$index}");
//                               },
//                               child: Card(
//                                   child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     color: Colors.transparent,
//                                     height: 175.0,
//                                     width: MediaQuery.of(context).size.width,
//                                     child: GridTile(
//                                         child: ClipRRect(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(4.0),
//                                           topRight: Radius.circular(4.0)),
//                                       child: Image.network(
//                                         snapshot.data[index]["image"],
//                                         fit: BoxFit.cover,
//                                       ),
//                                     )),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       left: 8.0,
//                                       right: 8.0,
//                                     ),
//                                     child: Divider(
//                                       color: appColor,
//                                       // height: 20,
//                                       thickness: 1,
//                                     ),
//                                   ),
//                                   Center(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           bottom: 8.0, right: 8.0, left: 8.0),
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                             "Name : ABCDEFGHIJKLMNO",
//                                             maxLines: 1,
//                                             overflow: TextOverflow.fade,
//                                             softWrap: false,
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 12.0,
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.all(2.0),
//                                           ),
//                                           Text(
//                                             "Weight : 10gm",
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             softWrap: false,
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 12.0,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                             ); // import "grid_card.dart" file
//                           }),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ));
//   }
// }

// // childAspectRatio: 0.7,
// //                     crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
// //                     children: List.generate(100, (index) {
// //                       return InkWell(
// //                         onTap: () {
// //                           print("tapped{$index}");
// //                         },
// //                         child: Card(
// //                             child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Container(
// //                               color: Colors.transparent,
// //                               height: 175.0,
// //                               width: MediaQuery.of(context).size.width,
// //                               child: GridTile(
// //                                   child: ClipRRect(
// //                                 borderRadius: BorderRadius.only(
// //                                     topLeft: Radius.circular(4.0),
// //                                     topRight: Radius.circular(4.0)),
// //                                 child:
// //                                     // Image.network(
// //                                     //   snapshot.data[index]["image"],
// //                                     //   fit: BoxFit.cover,
// //                                     // ),
// //                                     Text("R"),
// //                               )),
// //                             ),
// //                             Padding(
// //                               padding: const EdgeInsets.only(
// //                                 left: 8.0,
// //                                 right: 8.0,
// //                               ),
// //                               child: Divider(
// //                                 color: appColor,
// //                                 // height: 20,
// //                                 thickness: 1,
// //                               ),
// //                             ),
// //                             Center(
// //                                 child: Padding(
// //                                     padding: const EdgeInsets.only(
// //                                         bottom: 8.0, right: 8.0, left: 8.0),
// //                                     child: Column(
// //                                       children: [
// //                                         Text(
// //                                           "Name : ABCDEFGHIJKLMNO",
// //                                           maxLines: 1,
// //                                           overflow: TextOverflow.fade,
// //                                           softWrap: false,
// //                                           style: TextStyle(
// //                                             color: Colors.black,
// //                                             fontWeight: FontWeight.bold,
// //                                             fontSize: 12.0,
// //                                           ),
// //                                         ),
// //                                         Padding(
// //                                           padding: EdgeInsets.all(2.0),
// //                                         ),
// //                                         Text(
// //                                           "Weight : 10gm",
// //                                           maxLines: 1,
// //                                           overflow: TextOverflow.ellipsis,
// //                                           softWrap: false,
// //                                           style: TextStyle(
// //                                             color: Colors.black,
// //                                             fontWeight: FontWeight.bold,
// //                                             fontSize: 12.0,
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ))),
// //                           ],
// //                         )),
// //                       ); // import "grid_card.dart" file
// //                     }),
