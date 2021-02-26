// // import 'package:flutter/material.dart';

// // import 'dart:convert';

// // import 'package:http/http.dart' as http;

// // const String randomPersonURL = "https://reqres.in/api/users?page=2";

// // class PersonNetworkService {
// //   Future<List<Person>> fetchPersons(int amount) async {
// //     http.Response response = await http.get("$randomPersonURL?results=$amount");

// //     if (response.statusCode == 200) {
// //       Map peopleData = jsonDecode(response.body);
// //       List<dynamic> peoples = peopleData["data"];
// //       return peoples.map((json) => Person.fromJson(json)).toList();
// //     } else {
// //       throw Exception("Something gone wrong, ${response.statusCode}");
// //     }
// //   }
// // }

// // class Person {
// //   String name;
// //   String phoneNumber;
// //   String imageUrl;

// //   Person({this.name, this.phoneNumber, this.imageUrl});

// //   Person.fromJson(Map<String, dynamic> json)
// //       // : name =
// //       // "${json["name"]["title"]} ${json["name"]["first"]} ${json["name"]["last"]}",
// //       : name = json["first_name"],
// //         phoneNumber = json["email"],
// //         imageUrl = json["avatar"];
// // }

// // class HtmlJson extends StatelessWidget {
// //   final PersonNetworkService personService = PersonNetworkService();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         child: SafeArea(
// //           child: FutureBuilder(
// //             future: personService.fetchPersons(100),
// //             builder:
// //                 (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
// //               if (snapshot.hasData) {
// //                 return Row(
// //                   children: [
// //                     Expanded(
// //                       child: Container(
// //                         child: Card(
// //                           // color: Colors.black.withOpacity(0.5),
// //                           child: ListView.builder(
// //                               itemCount: snapshot.data.length,
// //                               itemBuilder: (BuildContext context, int index) {
// //                                 var currentPerson = snapshot.data[index];
// //                                 return ListTile(
// //                                   title: Text(currentPerson.name),
// //                                   leading: CircleAvatar(
// //                                     backgroundImage:
// //                                         NetworkImage(currentPerson.imageUrl),
// //                                   ),
// //                                   subtitle: Text(
// //                                       "Phone: ${currentPerson.phoneNumber}"),
// //                                 );
// //                               }),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               }

// //               if (snapshot.hasError) {
// //                 return Center(
// //                     child: Icon(
// //                   Icons.error,
// //                   color: Colors.red,
// //                   size: 82.0,
// //                 ));
// //               }

// //               return Center(
// //                   child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   CircularProgressIndicator(),
// //                   SizedBox(
// //                     height: 20.0,
// //                   ),
// //                   Text("Loading at the moment, please hold the line.")
// //                 ],
// //               ));
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:distributer_application/base/color_properties.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

// class ProductDescriptionPage extends StatefulWidget {
//   final String productId,
//       productName,
//       productSeries,
//       productQty,
//       categoryName,
//       categorySeries,
//       weight;
//   ProductDescriptionPage({
//     Key key,
//     @required this.productId,
//     @required this.productName,
//     @required this.productSeries,
//     @required this.productQty,
//     @required this.categoryName,
//     @required this.categorySeries,
//     @required this.weight,
//   }) : super(key: key);
//   @override
//   _ProductDescriptionPageState createState() => _ProductDescriptionPageState(
//       productId,
//       productName,
//       productSeries,
//       productQty,
//       categoryName,
//       categorySeries,
//       weight);
// }

// class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
//   static int count = 0;

//   final String productId,
//       productName,
//       productSeries,
//       productQty,
//       categoryName,
//       categorySeries,
//       weight;
//   _ProductDescriptionPageState(
//       this.productId,
//       this.productName,
//       this.productSeries,
//       this.productQty,
//       this.categoryName,
//       this.categorySeries,
//       this.weight);

//   //add function
//   void add() {
//     setState(() {
//       count++;
//     });
//   }

//   //minus function
//   void minus() {
//     setState(() {
//       if (count != 0) count--;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     count = 0;
//   }

//   final headingStyle = TextStyle(
//     fontSize: 16.0,
//     fontWeight: FontWeight.bold,
//     color: Colors.black87,
//   );

//   final subheadingStyle = TextStyle(
//     fontSize: 16.0,
//     color: Colors.grey[700],
//   );

//   Widget divider = Divider(
//     height: 1.0,
//   );

//   Widget separatorPadding = Padding(padding: EdgeInsets.all(10.0));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appColor,
//         elevation: 2.0,
//         centerTitle: true,
//         title: Text(
//           "Product Description",
//           style: TextStyle(
//             color: white,
//           ),
//         ),
//         iconTheme: IconThemeData(
//           color: white,
//         ),
// //        bottom: PreferredSize(
// //          child: Container(
// //            color: appColor,
// //            height: 1.5,
// //          ),
// //          preferredSize: Size.fromHeight(4.0),
// //        ),
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               SizedBox(
//                 height: 400.0,
//                 child: Swiper(
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container(
//                       child: Card(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(4.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(
// //                              snapshot.data[2][index]["images"][0]
//                                     "https://betasources.in//projects//grin-armer//public//product_images//gold-mushroom.jpg"),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: 3,
//                   outer: true,
//                   viewportFraction: 1,
//                   scale: 0.9,
//                   control: SwiperControl(
//                     color: white,
//                   ),
//                   pagination: SwiperPagination(
//                     builder: DotSwiperPaginationBuilder(
//                         color: Colors.grey[400],
//                         size: 6.0,
//                         activeColor: appColor,
//                         activeSize: 8.0),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.only(bottom: 32.0),
//                 child: Card(
//                   elevation: 0.5,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         top: 12.0, right: 10.0, left: 10.0, bottom: 4.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           productName,
//                           style: TextStyle(
//                             fontSize: 22.0,
//                             fontWeight: FontWeight.bold,
//                             color: appColor,
//                           ),
//                         ),
//                         Padding(padding: EdgeInsets.all(6.0)),
//                         SizedBox(
//                           height: 5,
//                           width: MediaQuery.of(context).size.width,
//                           child: Container(
//                             color: Color(0xFFf5f6f7),
//                           ),
//                         ),
//                         Padding(padding: EdgeInsets.all(8.0)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Category : ",
//                                           style: headingStyle,
//                                         ),
//                                         separatorPadding,
//                                         Text(
//                                           "P Series : ",
//                                           style: headingStyle,
//                                         ),
//                                         separatorPadding,
//                                         Text(
//                                           "C Series : ",
//                                           style: headingStyle,
//                                         ),
//                                         separatorPadding,
//                                         Text(
//                                           "Weight : ",
//                                           style: headingStyle,
//                                         ),
//                                         separatorPadding,
//                                       ],
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           categoryName,
//                                           style: subheadingStyle,
//                                         ),
//                                         separatorPadding,
//                                         Text(
//                                           productSeries,
//                                           style: subheadingStyle,
//                                         ),
//                                         separatorPadding,
//                                         Text(
//                                           categorySeries,
//                                           style: subheadingStyle,
//                                         ),
//                                         separatorPadding,
//                                         Text(weight,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             softWrap: false,
//                                             style: subheadingStyle),
//                                         separatorPadding,
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.red,
//                                         border: Border.all(color: Colors.red),
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(50.0),
//                                         )),
//                                     width:
//                                         36.0, //we have change width according to items left(same as count below)
//                                     child: Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Center(
//                                         child: Text(
//                                           "1",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12.0,
//                                           ),
//                                         ),
//                                       ),
//                                     )),
//                                 Padding(
//                                   padding: EdgeInsets.only(bottom: 8.0),
//                                 ),
//                                 Text(
//                                   "Piece(s) left",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5,
//                           width: MediaQuery.of(context).size.width,
//                           child: Container(
//                             color: Color(0xFFf5f6f7),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(10.0),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   "Quantity : ",
//                                   style: headingStyle,
//                                 ),
//                                 FloatingActionButton(
//                                   heroTag: null,
//                                   onPressed: add,
//                                   child: new Icon(
//                                     Icons.add,
//                                     color: appColor,
//                                   ),
//                                   elevation: 4.0,
//                                   backgroundColor: white,
//                                   mini: true,
//                                 ),
//                                 Container(
//                                   width: count > 99 ? 75.0 : 50.0,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Colors.grey[700],
//                                       ),
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(50.0),
//                                       )),
//                                   child: Center(
//                                     child: Padding(
//                                       padding: EdgeInsets.all(10.0),
//                                       child: Text('$count',
//                                           style: new TextStyle(fontSize: 20.0)),
//                                     ),
//                                   ),
//                                 ),
//                                 FloatingActionButton(
//                                   heroTag: null,
//                                   onPressed: minus,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                       bottom: 16.0,
//                                     ),
//                                     child: Icon(
//                                       Icons.minimize_rounded,
//                                       color: appColor,
//                                     ),
//                                   ),
//                                   elevation: 4.0,
//                                   backgroundColor: white,
//                                   mini: true,
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
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {},
//         elevation: 4.0,
//         tooltip: 'Add to card',
//         icon: Icon(
//           Icons.add,
//           color: white,
//         ),
//         label: Text(
//           "ADD TO CARD",
//           style: TextStyle(
//             color: white,
//           ),
//         ),
//         backgroundColor: appColor,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         clipBehavior: Clip.none,
//         // color: Colors.blue,
//         shape: CircularNotchedRectangle(),
//         child: Material(
//           child: SizedBox(
//             width: double.infinity,
//             height: 40.0,
//           ),
//           color: white,
//         ),
//       ),
// //       bottomNavigationBar: BottomAppBar(
// //         shape: CircularNotchedRectangle(),
// //         child: Row(
// // //          mainAxisSize: MainAxisSize.max,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             // FlatButton(
// //             //   color: appColor,
// //             //   textColor: Colors.white,
// //             //   disabledColor: Colors.grey,
// //             //   disabledTextColor: Colors.black,
// //             //   padding: EdgeInsets.all(12.0),
// //             //   splashColor: Colors.greenAccent,
// //             //   minWidth: MediaQuery.of(context).size.width - 100,
// //             //   onPressed: () {
// //             //     /*...*/
// //             //   },
// //             //   child: Text(
// //             //     "ADD TO CART",
// //             //     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
// //             //   ),
// //             // ),
// //             FloatingActionButton.extended(
// //               icon: Icon(Icons.add),
// //               label: Text("ADD TO CART"),
// //               onPressed: () {},
// //             ),
// //             Padding(padding: EdgeInsets.only(bottom: 16.0)),
// //           ],
// //         ),
// //       ),
//     );
//   }
// }






























































// import 'package:distributer_application/base/color_properties.dart';
// import 'package:distributer_application/screens/products/product_description_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:distributer_application/screens/basic/baseUrl.dart';

// // // const String url =
// // //     "https://randomuser.me/api/?page=%22%20+%20index.toString()%20+%20%22&results=20&seed=abc";

// // // class AllProductsPage extends StatefulWidget {
// // //   @override
// // //   _AllProductsPageState createState() => _AllProductsPageState();
// // // }

// // // class _AllProductsPageState extends State<AllProductsPage> {
// // //   // ScrollController scrollController;
// // //   // bool isLoading = false;
// // //   // static int page = 0;
// // //   // List products =  List();

// // //   // @override
// // //   // void initState() {
// // //   //   this.fetchProducts(page);
// // //   //   super.initState();
// // //   //   scrollController.addListener(() {
// // //   //     if (scrollController.position.pixels ==
// // //   //         scrollController.position.maxScrollExtent) {
// // //   //       fetchProducts(page);
// // //   //     }
// // //   //   });
// // //   // }

// // //   // @override
// // //   // void dispose() {
// // //   //   scrollController.dispose();
// // //   //   super.dispose();
// // //   // }

// // //   // void fetchProducts(int index) async {
// // //   //   if (!isLoading) {
// // //   //     setState(() {
// // //   //       isLoading = true;
// // //   //     });
// // //   //     // var url = "https://randomuser.me/api/?page=" +
// // //   //     //     index.toString() +
// // //   //     //     "&results=20&seed=abc";
// // //   //     // print(url);
// // //   //     // final response = await dio.get(url);
// // //   //     // List tList =  List();
// // //   //     // for (int i = 0; i &lt; response.data['results'].length; i++) {
// // //   //     //   tList.add(response.data['results'][i]);
// // //   //     // }

// // //   //     http.Response response = await http.get(url);

// // //   //     if (response.statusCode == 200) {
// // //   //       List tList =  List();
// // //   //       for (int i = 0; i < response.body.length; i++) {
// // //   //         tList.add(response.body[i]);
// // //   //       }
// // //   //       setState(() {
// // //   //         isLoading = false;
// // //   //         products.addAll(tList);
// // //   //         page++;
// // //   //       });
// // //   //       // return jsonDecode(response.body);
// // //   //     } else {
// // //   //       throw Exception("Error, ${response.statusCode}");
// // //   //     }
// // //   //   }
// // //   // }

// // //   // @override
// // //   // Widget build(BuildContext context) {
// // //   //   return Scaffold(
// // //   //       appBar: AppBar(
// // //   //         title: Text("Products"),
// // //   //       ),
// // //   //       body: buildProductList()
// // //   //       // FutureBuilder(
// // //   //       //   future: fetchProducts(),
// // //   //       //   builder: (context, snapshot) {
// // //   //       //     if (snapshot.hasData) {
// // //   //       //       return Container(
// // //   //       //         child: Padding(
// // //   //       //           padding: const EdgeInsets.all(8.0),
// // //   //       //           child: Container(
// // //   //       //             width: MediaQuery.of(context).size.width,
// // //   //       //             child: OrientationBuilder(
// // //   //       //               builder: (context, orientation) {
// // //   //       //                 return GridView.count(
// // //   //       //                   childAspectRatio: 0.7,
// // //   //       //                   crossAxisCount:
// // //   //       //                       orientation == Orientation.portrait ? 2 : 4,
// // //   //       //                   children:
// // //   //       //                       List.generate(snapshot.data.length, (index) {
// // //   //       //                     return InkWell(
// // //   //       //                       onTap: () {
// // //   //       //                         print("tapped{$index}");
// // //   //       //                       },
// // //   //       //                       child: Card(
// // //   //       //                           child: Column(
// // //   //       //                         mainAxisAlignment:
// // //   //       //                             MainAxisAlignment.spaceBetween,
// // //   //       //                         children: [
// // //   //       //                           Container(
// // //   //       //                             color: Colors.transparent,
// // //   //       //                             height: 175.0,
// // //   //       //                             width: MediaQuery.of(context).size.width,
// // //   //       //                             child: GridTile(
// // //   //       //                                 child: ClipRRect(
// // //   //       //                               borderRadius: BorderRadius.only(
// // //   //       //                                   topLeft: Radius.circular(4.0),
// // //   //       //                                   topRight: Radius.circular(4.0)),
// // //   //       //                               child: Image.network(
// // //   //       //                                 snapshot.data[index]["image"],
// // //   //       //                                 fit: BoxFit.cover,
// // //   //       //                               ),
// // //   //       //                             )),
// // //   //       //                           ),
// // //   //       //                           Padding(
// // //   //       //                             padding: const EdgeInsets.only(
// // //   //       //                               left: 8.0,
// // //   //       //                               right: 8.0,
// // //   //       //                             ),
// // //   //       //                             child: Divider(
// // //   //       //                               color: appColor,
// // //   //       //                               // height: 20,
// // //   //       //                               thickness: 1,
// // //   //       //                             ),
// // //   //       //                           ),
// // //   //       //                           Center(
// // //   //       //                               child: Padding(
// // //   //       //                                   padding: const EdgeInsets.only(
// // //   //       //                                       bottom: 8.0,
// // //   //       //                                       right: 8.0,
// // //   //       //                                       left: 8.0),
// // //   //       //                                   child: Column(
// // //   //       //                                     children: [
// // //   //       //                                       Text(
// // //   //       //                                         "Name : ABCDEFGHIJKLMNO",
// // //   //       //                                         maxLines: 1,
// // //   //       //                                         overflow: TextOverflow.fade,
// // //   //       //                                         softWrap: false,
// // //   //       //                                         style: TextStyle(
// // //   //       //                                           color: Colors.black,
// // //   //       //                                           fontWeight: FontWeight.bold,
// // //   //       //                                           fontSize: 12.0,
// // //   //       //                                         ),
// // //   //       //                                       ),
// // //   //       //                                       Padding(
// // //   //       //                                         padding: EdgeInsets.all(2.0),
// // //   //       //                                       ),
// // //   //       //                                       Text(
// // //   //       //                                         "Weight : 10gm",
// // //   //       //                                         maxLines: 1,
// // //   //       //                                         overflow: TextOverflow.ellipsis,
// // //   //       //                                         softWrap: false,
// // //   //       //                                         style: TextStyle(
// // //   //       //                                           color: Colors.black,
// // //   //       //                                           fontWeight: FontWeight.bold,
// // //   //       //                                           fontSize: 12.0,
// // //   //       //                                         ),
// // //   //       //                                       ),
// // //   //       //                                     ],
// // //   //       //                                   ))),
// // //   //       //                         ],
// // //   //       //                       )),
// // //   //       //                     ); // import "grid_card.dart" file
// // //   //       //                   }),
// // //   //       //                 );
// // //   //       //               },
// // //   //       //             ),
// // //   //       //           ),
// // //   //       //         ),
// // //   //       //       );
// // //   //       //     }
// // //   //       //     return Center(
// // //   //       //       child: CircularProgressIndicator(),
// // //   //       //     );
// // //   //       //   },
// // //   //       // )
// // //   //       );
// // //   // }

// // //   // Widget buildProductList() {
// // //   //   return ListView.builder(
// // //   //     itemCount:
// // //   //         products.length + 1, // Add one more item for progress indicator
// // //   //     padding: EdgeInsets.symmetric(vertical: 8.0),
// // //   //     itemBuilder: (BuildContext context, int index) {
// // //   //       if (index == products.length) {
// // //   //         return buildProgressIndicator();
// // //   //       } else {
// // //   //         return ListTile(
// // //   //           leading: CircleAvatar(
// // //   //             radius: 30.0,
// // //   //             backgroundImage: NetworkImage(
// // //   //               products[index]['picture']['large'],
// // //   //             ),
// // //   //           ),
// // //   //           title: Text((products[index]['name']['first'])),
// // //   //           subtitle: Text((products[index]['email'])),
// // //   //         );
// // //   //       }
// // //   //     },
// // //   //     controller: scrollController,
// // //   //   );
// // //   // }

// // //   // Widget buildProgressIndicator() {
// // //   //   return  Padding(
// // //   //     padding: const EdgeInsets.all(8.0),
// // //   //     child:  Center(
// // //   //       child:  Opacity(
// // //   //         opacity: isLoading ? 1.0 : 00,
// // //   //         child:  CircularProgressIndicator(),
// // //   //       ),
// // //   //     ),
// // //   //   );
// // //   // }

// // //   // ScrollController scrollcontroller;
// // //   // static int page = 0;
// // //   // bool isLoading = false;
// // //   // List users = List();
// // //   // // List<String> items = List.generate(100, (index) => 'Hello $index');

// // //   // @override
// // //   // void initState() {
// // //   //   this.fetchProducts(page);
// // //   //   super.initState();
// // //   //   scrollcontroller = ScrollController()..addListener(scrollListener);
// // //   // }

// // //   // @override
// // //   // void dispose() {
// // //   //   scrollcontroller.removeListener(scrollListener);
// // //   //   super.dispose();
// // //   // }

// // //   // void fetchProducts(int page) async {
// // //   //   if (!isLoading) {
// // //   //     setState(() {
// // //   //       isLoading = true;
// // //   //     });
// // //   //     http.Response response = await http.get(url);

// // //   //     // if (response.statusCode == 200) {
// // //   //     List tList = new List();
// // //   //     print(response.body.length);
// // //   //     for (int i = 0; i < response.body.length; i++) {
// // //   //       tList.add(jsonDecode(response.body));
// // //   //     }
// // //   //     setState(() {
// // //   //       isLoading = false;
// // //   //       users.addAll(tList);
// // //   //       page++;
// // //   //     });
// // //   //     // } else {
// // //   //     //   throw Exception("Error, ${response.statusCode}");
// // //   //     // }
// // //   //   }
// // //   // }

// // //   // @override
// // //   // Widget build(BuildContext context) {
// // //   //   return Scaffold(
// // //   //     body: Scrollbar(
// // //   //       child: Container(
// // //   //         child: Padding(
// // //   //           padding: const EdgeInsets.all(8.0),
// // //   //           child: Container(
// // //   //             width: MediaQuery.of(context).size.width,
// // //   //             child: OrientationBuilder(
// // //   //               builder: (context, orientation) {
// // //   //                 print("Length:");
// // //   //                 print(users.length);
// // //   //                 print(users);
// // //   //                 return GridView.builder(
// // //   //                   itemCount: users.length + 1,
// // //   //                   controller: scrollcontroller,
// // //   //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // //   //                     crossAxisCount:
// // //   //                         orientation == Orientation.portrait ? 2 : 4,
// // //   //                     mainAxisSpacing: 0.5,
// // //   //                     crossAxisSpacing: 0.5,
// // //   //                   ),
// // //   //                   itemBuilder: (context, index) {
// // //   //                     if (index == users.length) {
// // //   //                       return Center(child: CircularProgressIndicator());
// // //   //                     } else {
// // //   //                       return InkWell(
// // //   //                         onTap: () {
// // //   //                           print("tapped{$index}");
// // //   //                         },
// // //   //                         child: Card(
// // //   //                             child: Column(
// // //   //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //   //                           children: [
// // //   //                             Container(
// // //   //                               color: Colors.transparent,
// // //   //                               height: 100.0,
// // //   //                               width: MediaQuery.of(context).size.width,
// // //   //                               child: GridTile(
// // //   //                                   child: ClipRRect(
// // //   //                                 borderRadius: BorderRadius.only(
// // //   //                                     topLeft: Radius.circular(4.0),
// // //   //                                     topRight: Radius.circular(4.0)),
// // //   //                                 child: Image.network(
// // //   //                                   users[index]["image"],
// // //   //                                   fit: BoxFit.cover,
// // //   //                                 ),
// // //   //                                 // Text("R"),
// // //   //                               )),
// // //   //                             ),
// // //   //                             Padding(
// // //   //                               padding: const EdgeInsets.only(
// // //   //                                 left: 8.0,
// // //   //                                 right: 8.0,
// // //   //                               ),
// // //   //                               child: Divider(
// // //   //                                 color: appColor,
// // //   //                                 // height: 20,
// // //   //                                 thickness: 1,
// // //   //                               ),
// // //   //                             ),
// // //   //                             Center(
// // //   //                               child: Padding(
// // //   //                                 padding: const EdgeInsets.only(
// // //   //                                     bottom: 8.0, right: 8.0, left: 8.0),
// // //   //                                 child: Column(
// // //   //                                   children: [
// // //   //                                     Text(
// // //   //                                       "Name : ABCDEFGHIJKLMNO",
// // //   //                                       maxLines: 1,
// // //   //                                       overflow: TextOverflow.fade,
// // //   //                                       softWrap: false,
// // //   //                                       style: TextStyle(
// // //   //                                         color: Colors.black,
// // //   //                                         fontWeight: FontWeight.bold,
// // //   //                                         fontSize: 12.0,
// // //   //                                       ),
// // //   //                                     ),
// // //   //                                     Padding(
// // //   //                                       padding: EdgeInsets.all(2.0),
// // //   //                                     ),
// // //   //                                     Text(
// // //   //                                       "Weight : 10gm",
// // //   //                                       maxLines: 1,
// // //   //                                       overflow: TextOverflow.ellipsis,
// // //   //                                       softWrap: false,
// // //   //                                       style: TextStyle(
// // //   //                                         color: Colors.black,
// // //   //                                         fontWeight: FontWeight.bold,
// // //   //                                         fontSize: 12.0,
// // //   //                                       ),
// // //   //                                     ),
// // //   //                                   ],
// // //   //                                 ),
// // //   //                               ),
// // //   //                             ),
// // //   //                           ],
// // //   //                         )),
// // //   //                       );
// // //   //                     }
// // //   //                   },
// // //   //                 );
// // //   //               },
// // //   //             ),
// // //   //           ),
// // //   //         ),
// // //   //       ),
// // //   //     ),
// // //   //   );
// // //   // }

// // //   // void scrollListener() {
// // //   //   if (scrollcontroller.position.pixels ==
// // //   //       scrollcontroller.position.maxScrollExtent) {
// // //   //     fetchProducts(page);
// // //   //   }
// // //   // }

// // // }

// // import 'package:distributer_application/base/color_properties.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

// // const String url = "https://bhaveshjewellers.in/admin/get-all-products";

// // class AllProductsPage extends StatefulWidget {
// //   @override
// //   _AllProductsPageState createState() => _AllProductsPageState();
// // }

// // class _AllProductsPageState extends State<AllProductsPage> {
// //   List<int> verticalData = [];
// //   List<dynamic> productsData = [];
// //   final int increment = 4;
// //   bool isLoadingVertical = false;

// //   @override
// //   void initState() {
// //     _loadMoreVertical();
// //     super.initState();
// //   }

// //   Future _loadMoreVertical() async {
// //     setState(() {
// //       isLoadingVertical = true;
// //     });

// //     http.Response response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       productsData = jsonDecode(response.body);
// //       print(productsData[0]["category"]);
// //       print(productsData[0]["products"][0]["product_name"]);
// //       print(productsData[0]["products"][0]["images"]);
// //       // return jsonDecode(response.body);
// //     } else {
// //       throw Exception("Error, ${response.statusCode}");
// //     }

// //     // Add in an artificial delay
// //     await Future.delayed(const Duration(seconds: 1));

// //     verticalData.addAll(
// //         List.generate(increment, (index) => verticalData.length + index));

// //     productsData.addAll(
// //         List.generate(increment, (index) => productsData.length + index));

// //     setState(() {
// //       isLoadingVertical = false;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Products"),
// //       ),
// //       body: LazyLoadScrollView(
// //         isLoading: isLoadingVertical,
// //         onEndOfPage: () => _loadMoreVertical(),
// //         child: Scrollbar(
// //           child: OrientationBuilder(
// //             builder: (context, orientation) {
// //               return GridView.builder(
// //                 itemCount: productsData.length,
// //                 // shrinkWrap: true,
// //                 // physics: NeverScrollableScrollPhysics(),
// //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
// //                   mainAxisSpacing: 0.5,
// //                   crossAxisSpacing: 0.5,
// //                   childAspectRatio: 0.7,
// //                 ),
// //                 itemBuilder: (context, index) {
// //                   // if (index == users.length) {
// //                   //   return Center(child: CircularProgressIndicator());
// //                   // } else {
// //                   return InkWell(
// //                     onTap: () {
// //                       print(productsData[0]["products"][index]["id"]);
// //                     },
// //                     child: Card(
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Container(
// //                             color: Colors.transparent,
// //                             height: 175.0,
// //                             width: MediaQuery.of(context).size.width,
// //                             child: GridTile(
// //                                 child: ClipRRect(
// //                               borderRadius: BorderRadius.only(
// //                                   topLeft: Radius.circular(4.0),
// //                                   topRight: Radius.circular(4.0)),
// //                               child: Image.network(
// //                                 productsData[0]["products"][index]["images"][0],
// //                                 fit: BoxFit.cover,
// //                               ),
// //                               // Text("R"),
// //                             )),
// //                           ),
// //                           Padding(
// //                             padding: const EdgeInsets.only(
// //                               left: 8.0,
// //                               right: 8.0,
// //                             ),
// //                             child: Divider(
// //                               color: appColor,
// //                               // height: 20,
// //                               thickness: 1,
// //                             ),
// //                           ),
// //                           Center(
// //                             child: Padding(
// //                               padding: const EdgeInsets.only(
// //                                   bottom: 8.0, right: 8.0, left: 8.0),
// //                               child: Column(
// //                                 children: [
// //                                   Text(
// //                                     "Name : ABCDEFGHIJKLMNO",
// //                                     maxLines: 1,
// //                                     overflow: TextOverflow.fade,
// //                                     softWrap: false,
// //                                     style: TextStyle(
// //                                       color: Colors.black,
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 12.0,
// //                                     ),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(2.0),
// //                                   ),
// //                                   Text(
// //                                     "Weight : 10gm",
// //                                     maxLines: 1,
// //                                     overflow: TextOverflow.ellipsis,
// //                                     softWrap: false,
// //                                     style: TextStyle(
// //                                       color: Colors.black,
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 12.0,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class AllProductsPage extends StatefulWidget {
//   static const int PAGE_SIZE = 4;
//   final String categoryId, categoryName;
//   AllProductsPage(
//       {Key key, @required this.categoryId, @required this.categoryName})
//       : super(key: key);
//   @override
//   _AllProductsPageState createState() =>
//       _AllProductsPageState(categoryId, categoryName);
// }

// class _AllProductsPageState extends State<AllProductsPage> {
//   final String categoryId, categoryName;
//   _AllProductsPageState(this.categoryId, this.categoryName);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appColor,
//         elevation: 2.0,
//         centerTitle: true,
//         title: Text(
//           categoryName,
//           maxLines: 1,
//           overflow: TextOverflow.fade,
//           softWrap: false,
//           style: TextStyle(
//             color: white,
//           ),
//         ),
//         iconTheme: IconThemeData(
//           color: white,
//         ),
//       ),
//       body: SafeArea(
//         child: OrientationBuilder(
//           builder: (context, orientation) {
//             return PagewiseGridView.count(
//               pageSize: AllProductsPage.PAGE_SIZE,
//               crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
//               // mainAxisSpacing: 1.0,
//               // crossAxisSpacing: 1.0,
//               childAspectRatio: 0.65,
//               padding: EdgeInsets.all(15.0),
//               itemBuilder: this._itemBuilder,
//               pageFuture: (pageIndex) => BackendService.getImages(
//                   pageIndex * AllProductsPage.PAGE_SIZE,
//                   AllProductsPage.PAGE_SIZE,
//                   categoryId),
//               loadingBuilder: (context) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//               noItemsFoundBuilder: (context) {
//                 return Center(
//                   child: Text("No more products"),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _itemBuilder(context, ProductModel entry, index) {
//     return Card(
//         child: InkWell(
//       onTap: () {
//         print("tapped" + entry.id);
//         Navigator.of(context).push(
//           MaterialPageRoute(
//               builder: (_) => ProductDescriptionPage(
//                     productId: entry.id,
//                     productName: entry.productName,
//                     productSeries: entry.productSeries,
//                     productQty: entry.productQty,
//                     categoryName: entry.categoryName,
//                     categorySeries: entry.categorySeries,
//                     weight: entry.weight,
//                   )),
//         );
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             color: Colors.transparent,
//             height: 175.0,
//             width: MediaQuery.of(context).size.width,
//             child: GridTile(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(4.0),
//                   topRight: Radius.circular(4.0),
//                 ),
//                 child: Image.network(
//                   entry.img,
//                   fit: BoxFit.cover,
//                 ),
//                 // Text("R"),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 8.0,
//               right: 8.0,
//             ),
//             child: Divider(
//               color: appColor,
//               // height: 20,
//               thickness: 1,
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding:
//                   const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     entry.productName,
//                     maxLines: 1,
//                     overflow: TextOverflow.fade,
//                     softWrap: false,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12.0,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(2.0),
//                   ),
//                   Text(
//                     entry.categoryName,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: false,
//                     style: TextStyle(
//                       color: grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

// class BackendService {
//   static Future<List<ProductModel>> getImages(offset, limit, categoryId) async {
//     final String url = baseUrl +
//         '/get-category-products?start=$offset&limit=$limit&category=$categoryId';
//     // final responseBody = (await http.get(
//     //         'http://jsonplaceholder.typicode.com/photos?_start=$offset&_limit=$limit'))
//     //     .body;

//     final response = (await http.get(url));

//     final responseBody = response.body;
//     print(responseBody);

//     // The response body is an array of items.
//     return ProductModel.fromJsonList(json.decode(responseBody));
//   }
// }

// class ProductModel {
//   String id;
//   String categoryName;
//   String productName;
//   String img;
//   String productSeries;
//   String productQty;
//   String categorySeries;
//   String images;
//   String weight;

//   ProductModel.fromJson(obj) {
//     this.id = obj['id'];
//     // this.category = obj['category'];
//     this.categoryName = obj['cat_name'];
//     this.img = obj['images'][0];
//     this.productName = obj["product_name"];
//     this.productSeries = obj['product_series'];
//     this.productQty = obj['pro_qty'];
//     this.categorySeries = obj['cat_series'];
//     this.images = obj['images'];
//     this.weight = obj['weight'];
//   }

//   static List<ProductModel> fromJsonList(jsonList) {
//     return jsonList
//         .map<ProductModel>((obj) => ProductModel.fromJson(obj))
//         .toList();
//   }
// }
