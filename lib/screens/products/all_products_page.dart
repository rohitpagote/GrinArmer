import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/base/custom_loader.dart';
import 'package:distributer_application/home/home_page.dart';
import 'package:distributer_application/screens/products/product_description_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:distributer_application/screens/basic/baseUrl.dart';

// // const String url =
// //     "https://randomuser.me/api/?page=%22%20+%20index.toString()%20+%20%22&results=20&seed=abc";

// // class AllProductsPage extends StatefulWidget {
// //   @override
// //   _AllProductsPageState createState() => _AllProductsPageState();
// // }

// // class _AllProductsPageState extends State<AllProductsPage> {
// //   // ScrollController scrollController;
// //   // bool isLoading = false;
// //   // static int page = 0;
// //   // List products =  List();

// //   // @override
// //   // void initState() {
// //   //   this.fetchProducts(page);
// //   //   super.initState();
// //   //   scrollController.addListener(() {
// //   //     if (scrollController.position.pixels ==
// //   //         scrollController.position.maxScrollExtent) {
// //   //       fetchProducts(page);
// //   //     }
// //   //   });
// //   // }

// //   // @override
// //   // void dispose() {
// //   //   scrollController.dispose();
// //   //   super.dispose();
// //   // }

// //   // void fetchProducts(int index) async {
// //   //   if (!isLoading) {
// //   //     setState(() {
// //   //       isLoading = true;
// //   //     });
// //   //     // var url = "https://randomuser.me/api/?page=" +
// //   //     //     index.toString() +
// //   //     //     "&results=20&seed=abc";
// //   //     // print(url);
// //   //     // final response = await dio.get(url);
// //   //     // List tList =  List();
// //   //     // for (int i = 0; i &lt; response.data['results'].length; i++) {
// //   //     //   tList.add(response.data['results'][i]);
// //   //     // }

// //   //     http.Response response = await http.get(url);

// //   //     if (response.statusCode == 200) {
// //   //       List tList =  List();
// //   //       for (int i = 0; i < response.body.length; i++) {
// //   //         tList.add(response.body[i]);
// //   //       }
// //   //       setState(() {
// //   //         isLoading = false;
// //   //         products.addAll(tList);
// //   //         page++;
// //   //       });
// //   //       // return jsonDecode(response.body);
// //   //     } else {
// //   //       throw Exception("Error, ${response.statusCode}");
// //   //     }
// //   //   }
// //   // }

// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return Scaffold(
// //   //       appBar: AppBar(
// //   //         title: Text("Products"),
// //   //       ),
// //   //       body: buildProductList()
// //   //       // FutureBuilder(
// //   //       //   future: fetchProducts(),
// //   //       //   builder: (context, snapshot) {
// //   //       //     if (snapshot.hasData) {
// //   //       //       return Container(
// //   //       //         child: Padding(
// //   //       //           padding: const EdgeInsets.all(8.0),
// //   //       //           child: Container(
// //   //       //             width: MediaQuery.of(context).size.width,
// //   //       //             child: OrientationBuilder(
// //   //       //               builder: (context, orientation) {
// //   //       //                 return GridView.count(
// //   //       //                   childAspectRatio: 0.7,
// //   //       //                   crossAxisCount:
// //   //       //                       orientation == Orientation.portrait ? 2 : 4,
// //   //       //                   children:
// //   //       //                       List.generate(snapshot.data.length, (index) {
// //   //       //                     return InkWell(
// //   //       //                       onTap: () {
// //   //       //                         print("tapped{$index}");
// //   //       //                       },
// //   //       //                       child: Card(
// //   //       //                           child: Column(
// //   //       //                         mainAxisAlignment:
// //   //       //                             MainAxisAlignment.spaceBetween,
// //   //       //                         children: [
// //   //       //                           Container(
// //   //       //                             color: Colors.transparent,
// //   //       //                             height: 175.0,
// //   //       //                             width: MediaQuery.of(context).size.width,
// //   //       //                             child: GridTile(
// //   //       //                                 child: ClipRRect(
// //   //       //                               borderRadius: BorderRadius.only(
// //   //       //                                   topLeft: Radius.circular(4.0),
// //   //       //                                   topRight: Radius.circular(4.0)),
// //   //       //                               child: Image.network(
// //   //       //                                 snapshot.data[index]["image"],
// //   //       //                                 fit: BoxFit.cover,
// //   //       //                               ),
// //   //       //                             )),
// //   //       //                           ),
// //   //       //                           Padding(
// //   //       //                             padding: const EdgeInsets.only(
// //   //       //                               left: 8.0,
// //   //       //                               right: 8.0,
// //   //       //                             ),
// //   //       //                             child: Divider(
// //   //       //                               color: appColor,
// //   //       //                               // height: 20,
// //   //       //                               thickness: 1,
// //   //       //                             ),
// //   //       //                           ),
// //   //       //                           Center(
// //   //       //                               child: Padding(
// //   //       //                                   padding: const EdgeInsets.only(
// //   //       //                                       bottom: 8.0,
// //   //       //                                       right: 8.0,
// //   //       //                                       left: 8.0),
// //   //       //                                   child: Column(
// //   //       //                                     children: [
// //   //       //                                       Text(
// //   //       //                                         "Name : ABCDEFGHIJKLMNO",
// //   //       //                                         maxLines: 1,
// //   //       //                                         overflow: TextOverflow.fade,
// //   //       //                                         softWrap: false,
// //   //       //                                         style: TextStyle(
// //   //       //                                           color: Colors.black,
// //   //       //                                           fontWeight: FontWeight.bold,
// //   //       //                                           fontSize: 12.0,
// //   //       //                                         ),
// //   //       //                                       ),
// //   //       //                                       Padding(
// //   //       //                                         padding: EdgeInsets.all(2.0),
// //   //       //                                       ),
// //   //       //                                       Text(
// //   //       //                                         "Weight : 10gm",
// //   //       //                                         maxLines: 1,
// //   //       //                                         overflow: TextOverflow.ellipsis,
// //   //       //                                         softWrap: false,
// //   //       //                                         style: TextStyle(
// //   //       //                                           color: Colors.black,
// //   //       //                                           fontWeight: FontWeight.bold,
// //   //       //                                           fontSize: 12.0,
// //   //       //                                         ),
// //   //       //                                       ),
// //   //       //                                     ],
// //   //       //                                   ))),
// //   //       //                         ],
// //   //       //                       )),
// //   //       //                     ); // import "grid_card.dart" file
// //   //       //                   }),
// //   //       //                 );
// //   //       //               },
// //   //       //             ),
// //   //       //           ),
// //   //       //         ),
// //   //       //       );
// //   //       //     }
// //   //       //     return Center(
// //   //       //       child: CircularProgressIndicator(),
// //   //       //     );
// //   //       //   },
// //   //       // )
// //   //       );
// //   // }

// //   // Widget buildProductList() {
// //   //   return ListView.builder(
// //   //     itemCount:
// //   //         products.length + 1, // Add one more item for progress indicator
// //   //     padding: EdgeInsets.symmetric(vertical: 8.0),
// //   //     itemBuilder: (BuildContext context, int index) {
// //   //       if (index == products.length) {
// //   //         return buildProgressIndicator();
// //   //       } else {
// //   //         return ListTile(
// //   //           leading: CircleAvatar(
// //   //             radius: 30.0,
// //   //             backgroundImage: NetworkImage(
// //   //               products[index]['picture']['large'],
// //   //             ),
// //   //           ),
// //   //           title: Text((products[index]['name']['first'])),
// //   //           subtitle: Text((products[index]['email'])),
// //   //         );
// //   //       }
// //   //     },
// //   //     controller: scrollController,
// //   //   );
// //   // }

// //   // Widget buildProgressIndicator() {
// //   //   return  Padding(
// //   //     padding: const EdgeInsets.all(8.0),
// //   //     child:  Center(
// //   //       child:  Opacity(
// //   //         opacity: isLoading ? 1.0 : 00,
// //   //         child:  CircularProgressIndicator(),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }

// //   // ScrollController scrollcontroller;
// //   // static int page = 0;
// //   // bool isLoading = false;
// //   // List users = List();
// //   // // List<String> items = List.generate(100, (index) => 'Hello $index');

// //   // @override
// //   // void initState() {
// //   //   this.fetchProducts(page);
// //   //   super.initState();
// //   //   scrollcontroller = ScrollController()..addListener(scrollListener);
// //   // }

// //   // @override
// //   // void dispose() {
// //   //   scrollcontroller.removeListener(scrollListener);
// //   //   super.dispose();
// //   // }

// //   // void fetchProducts(int page) async {
// //   //   if (!isLoading) {
// //   //     setState(() {
// //   //       isLoading = true;
// //   //     });
// //   //     http.Response response = await http.get(url);

// //   //     // if (response.statusCode == 200) {
// //   //     List tList = new List();
// //   //     print(response.body.length);
// //   //     for (int i = 0; i < response.body.length; i++) {
// //   //       tList.add(jsonDecode(response.body));
// //   //     }
// //   //     setState(() {
// //   //       isLoading = false;
// //   //       users.addAll(tList);
// //   //       page++;
// //   //     });
// //   //     // } else {
// //   //     //   throw Exception("Error, ${response.statusCode}");
// //   //     // }
// //   //   }
// //   // }

// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return Scaffold(
// //   //     body: Scrollbar(
// //   //       child: Container(
// //   //         child: Padding(
// //   //           padding: const EdgeInsets.all(8.0),
// //   //           child: Container(
// //   //             width: MediaQuery.of(context).size.width,
// //   //             child: OrientationBuilder(
// //   //               builder: (context, orientation) {
// //   //                 print("Length:");
// //   //                 print(users.length);
// //   //                 print(users);
// //   //                 return GridView.builder(
// //   //                   itemCount: users.length + 1,
// //   //                   controller: scrollcontroller,
// //   //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //   //                     crossAxisCount:
// //   //                         orientation == Orientation.portrait ? 2 : 4,
// //   //                     mainAxisSpacing: 0.5,
// //   //                     crossAxisSpacing: 0.5,
// //   //                   ),
// //   //                   itemBuilder: (context, index) {
// //   //                     if (index == users.length) {
// //   //                       return Center(child: CircularProgressIndicator());
// //   //                     } else {
// //   //                       return InkWell(
// //   //                         onTap: () {
// //   //                           print("tapped{$index}");
// //   //                         },
// //   //                         child: Card(
// //   //                             child: Column(
// //   //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   //                           children: [
// //   //                             Container(
// //   //                               color: Colors.transparent,
// //   //                               height: 100.0,
// //   //                               width: MediaQuery.of(context).size.width,
// //   //                               child: GridTile(
// //   //                                   child: ClipRRect(
// //   //                                 borderRadius: BorderRadius.only(
// //   //                                     topLeft: Radius.circular(4.0),
// //   //                                     topRight: Radius.circular(4.0)),
// //   //                                 child: Image.network(
// //   //                                   users[index]["image"],
// //   //                                   fit: BoxFit.cover,
// //   //                                 ),
// //   //                                 // Text("R"),
// //   //                               )),
// //   //                             ),
// //   //                             Padding(
// //   //                               padding: const EdgeInsets.only(
// //   //                                 left: 8.0,
// //   //                                 right: 8.0,
// //   //                               ),
// //   //                               child: Divider(
// //   //                                 color: appColor,
// //   //                                 // height: 20,
// //   //                                 thickness: 1,
// //   //                               ),
// //   //                             ),
// //   //                             Center(
// //   //                               child: Padding(
// //   //                                 padding: const EdgeInsets.only(
// //   //                                     bottom: 8.0, right: 8.0, left: 8.0),
// //   //                                 child: Column(
// //   //                                   children: [
// //   //                                     Text(
// //   //                                       "Name : ABCDEFGHIJKLMNO",
// //   //                                       maxLines: 1,
// //   //                                       overflow: TextOverflow.fade,
// //   //                                       softWrap: false,
// //   //                                       style: TextStyle(
// //   //                                         color: Colors.black,
// //   //                                         fontWeight: FontWeight.bold,
// //   //                                         fontSize: 12.0,
// //   //                                       ),
// //   //                                     ),
// //   //                                     Padding(
// //   //                                       padding: EdgeInsets.all(2.0),
// //   //                                     ),
// //   //                                     Text(
// //   //                                       "Weight : 10gm",
// //   //                                       maxLines: 1,
// //   //                                       overflow: TextOverflow.ellipsis,
// //   //                                       softWrap: false,
// //   //                                       style: TextStyle(
// //   //                                         color: Colors.black,
// //   //                                         fontWeight: FontWeight.bold,
// //   //                                         fontSize: 12.0,
// //   //                                       ),
// //   //                                     ),
// //   //                                   ],
// //   //                                 ),
// //   //                               ),
// //   //                             ),
// //   //                           ],
// //   //                         )),
// //   //                       );
// //   //                     }
// //   //                   },
// //   //                 );
// //   //               },
// //   //             ),
// //   //           ),
// //   //         ),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }

// //   // void scrollListener() {
// //   //   if (scrollcontroller.position.pixels ==
// //   //       scrollcontroller.position.maxScrollExtent) {
// //   //     fetchProducts(page);
// //   //   }
// //   // }

// // }

// import 'package:distributer_application/base/color_properties.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

// const String url = "https://bhaveshjewellers.in/admin/get-all-products";

// class AllProductsPage extends StatefulWidget {
//   @override
//   _AllProductsPageState createState() => _AllProductsPageState();
// }

// class _AllProductsPageState extends State<AllProductsPage> {
//   List<int> verticalData = [];
//   List<dynamic> productsData = [];
//   final int increment = 4;
//   bool isLoadingVertical = false;

//   @override
//   void initState() {
//     _loadMoreVertical();
//     super.initState();
//   }

//   Future _loadMoreVertical() async {
//     setState(() {
//       isLoadingVertical = true;
//     });

//     http.Response response = await http.get(url);

//     if (response.statusCode == 200) {
//       productsData = jsonDecode(response.body);
//       print(productsData[0]["category"]);
//       print(productsData[0]["products"][0]["product_name"]);
//       print(productsData[0]["products"][0]["images"]);
//       // return jsonDecode(response.body);
//     } else {
//       throw Exception("Error, ${response.statusCode}");
//     }

//     // Add in an artificial delay
//     await Future.delayed(const Duration(seconds: 1));

//     verticalData.addAll(
//         List.generate(increment, (index) => verticalData.length + index));

//     productsData.addAll(
//         List.generate(increment, (index) => productsData.length + index));

//     setState(() {
//       isLoadingVertical = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Products"),
//       ),
//       body: LazyLoadScrollView(
//         isLoading: isLoadingVertical,
//         onEndOfPage: () => _loadMoreVertical(),
//         child: Scrollbar(
//           child: OrientationBuilder(
//             builder: (context, orientation) {
//               return GridView.builder(
//                 itemCount: productsData.length,
//                 // shrinkWrap: true,
//                 // physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
//                   mainAxisSpacing: 0.5,
//                   crossAxisSpacing: 0.5,
//                   childAspectRatio: 0.7,
//                 ),
//                 itemBuilder: (context, index) {
//                   // if (index == users.length) {
//                   //   return Center(child: CircularProgressIndicator());
//                   // } else {
//                   return InkWell(
//                     onTap: () {
//                       print(productsData[0]["products"][index]["id"]);
//                     },
//                     child: Card(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             color: Colors.transparent,
//                             height: 175.0,
//                             width: MediaQuery.of(context).size.width,
//                             child: GridTile(
//                                 child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(4.0),
//                                   topRight: Radius.circular(4.0)),
//                               child: Image.network(
//                                 productsData[0]["products"][index]["images"][0],
//                                 fit: BoxFit.cover,
//                               ),
//                               // Text("R"),
//                             )),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               left: 8.0,
//                               right: 8.0,
//                             ),
//                             child: Divider(
//                               color: appColor,
//                               // height: 20,
//                               thickness: 1,
//                             ),
//                           ),
//                           Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   bottom: 8.0, right: 8.0, left: 8.0),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     "Name : ABCDEFGHIJKLMNO",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.fade,
//                                     softWrap: false,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12.0,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(2.0),
//                                   ),
//                                   Text(
//                                     "Weight : 10gm",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     softWrap: false,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class AllProductsPage extends StatefulWidget {
  static const int PAGE_SIZE = 4;
  final String categoryId, categoryName;
  final Function refresh;
  final int cartItemCount;

  AllProductsPage(
      {Key key, @required this.categoryId, @required this.categoryName, this.refresh, this.cartItemCount})
      : super(key: key);

  @override
  _AllProductsPageState createState() =>
      _AllProductsPageState(categoryId, categoryName, refresh, cartItemCount);
}

class _AllProductsPageState extends State<AllProductsPage> {
  final String categoryId, categoryName;
  final Function refresh;
  final int cartItemCount;

  _AllProductsPageState(this.categoryId, this.categoryName, this.refresh, this.cartItemCount);

  moveToHomePage(){
    refresh();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return moveToHomePage();
      },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            elevation: 2.0,
            centerTitle: true,
            title: Text(
              categoryName,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                color: white,
              ),
            ),
            iconTheme: IconThemeData(
              color: white,
            ),
            leading: GestureDetector(
              onTap: (){
                moveToHomePage();
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: SafeArea(
            child: OrientationBuilder(
              builder: (context, orientation) {
                return PagewiseGridView.count(
                    pageSize: AllProductsPage.PAGE_SIZE,
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                    // mainAxisSpacing: 1.0,
                    // crossAxisSpacing: 1.0,
                    childAspectRatio: 0.65,
                    padding: EdgeInsets.all(15.0),
                    itemBuilder: this._itemBuilder,
                    pageFuture: (pageIndex) => BackendService.getImages(
                        pageIndex * AllProductsPage.PAGE_SIZE,
                        AllProductsPage.PAGE_SIZE,
                        categoryId),
                    loadingBuilder: (context) {
                      return Center(
                        child: CustomLoader(),
                      );
                    },
                    noItemsFoundBuilder: (context) {
                      return Center(
                        child: Text("Sorry, no products to show."),
                      );
                    },
                    retryBuilder: (context, callback) {
                      return RaisedButton(
                          child: Text('Retry'), onPressed: () => callback());
                    });
              },
            ),
          ),
        ),);
  }

  Widget _itemBuilder(context, ProductModel entry, index) {
    return Card(
      child: InkWell(
        onTap: () {
          print("tapped" + entry.id);
          print(entry.images);
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => ProductDescriptionPage(
                productId: entry.id,
                productName: entry.productName,
                productSeries: entry.productSeries,
                productQty: entry.productQty,
                categoryName: entry.categoryName,
                categorySeries: entry.categorySeries,
                weight: entry.weight,
                images: entry.images,
                  cartItemCount: cartItemCount,
              ),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
        child: SizedBox(
          height: 175.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                    child: Image.network(
                      entry.img,
                      fit: BoxFit.cover,
                    ),
                    // Text("R"),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
                  child: Column(
                    children: [
                      Divider(
                        color: appColor,
                        thickness: 1,
                      ),
                      Text(
                        entry.productName,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(
                        entry.categoryName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
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
    );
  }
}

class BackendService {
  static Future<List<ProductModel>> getImages(offset, limit, categoryId) async {
    final String url = baseUrl +
        '/get-category-products?start=$offset&limit=$limit&category=$categoryId';
    // final responseBody = (await http.get(
    //         'http://jsonplaceholder.typicode.com/photos?_start=$offset&_limit=$limit'))
    //     .body;

    final response = (await http.get(url));

    final responseBody = response.body;
    print(responseBody);

    // The response body is an array of items.
    return ProductModel.fromJsonList(json.decode(responseBody));
  }
}

class ProductModel {
  String id;
  String productName;
  String productSeries;
  String productQty;
  String categoryName;
  String categorySeries;
  String weight;
  String img;
  List<dynamic> images;

  ProductModel.fromJson(obj) {
    this.id = obj['id'];
    this.productName = obj["product_name"];
    this.productSeries = obj['product_series'];
    this.productQty = obj['pro_qty'];
    this.categoryName = obj['cat_name'];
    this.categorySeries = obj['cat_series'];
    this.weight = obj['weight'];
    this.img = obj['images'][0];
    this.images = obj['images'];
    print("images");
    print(this.images);
    print(this.images[0]);
    // obj['images'].forEach((element) {
    //   this.images.add(element);
    // });
    // for (int i = 0; i < obj['images'].length; i++) {
    //   this.images[i] = obj['images'][i];
    // }
  }

  static List<ProductModel> fromJsonList(jsonList) {
    return jsonList
        .map<ProductModel>((obj) => ProductModel.fromJson(obj))
        .toList();
  }
}
