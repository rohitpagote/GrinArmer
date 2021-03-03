import 'dart:convert';

import 'package:distributer_application/auth/showErrDialog.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/base/custom_loader.dart';
import 'package:distributer_application/base/zoomingImg.dart';
import 'package:distributer_application/home/components/demo_file.dart';
import 'package:distributer_application/home/home_page.dart';
import 'package:distributer_application/screens/products/cart_product_management.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:easy_loader/easy_loader.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  // List<String> productsIds = [];
  // create() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList("products", productsIds);
  // }

  // add() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   productsIds.add("1");
  //   prefs.setStringList("products", productsIds);
  // }

  // show() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   productsIds = prefs.getStringList("products");
  //   print(productsIds);
  // }

  // remove() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   productsIds = prefs.getStringList("products");
  //   productsIds.removeWhere((productId) => productId == '1');
  //   prefs.setStringList("products", productsIds);
  //   print(productsIds);
  // }

  // showProductId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> productIds;
  //   productIds = prefs.getStringList("productIds");
  //   print(productIds);
  // }

  final String getProductsWithRefIdsUrl =
      "https://betasources.in/projects/grin-armer/get-cart-products";

  final imageList = [
    'assets/google.png',
    'assets/facebook.png',
    'assets/google.png',
  ];

  List<String> cartProducts;
  List<String> productIds = [];
  List<String> count = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<dynamic>> getProductsWithRefProductIds() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    cartProducts = prefs.getStringList("cartProducts");
//    print(cartProducts);
//    cartProducts.forEach((element) {
//      var m = jsonDecode(element);
//      var u = Cart.fromJson(m);
//      productIds.add(u.productId);
//    });
//    print(productIds);
//    cartProducts.forEach((element) {
//      var m = jsonDecode(element);
//      var u = Cart.fromJson(m);
//      count.add(u.count);
//    });
//    print(count);
//    http.Response response = await http.post(getProductsWithRefIdsUrl, body: {
//      'products_ids': jsonEncode(productIds),
//    });
//    print(response.body);
//    return jsonDecode(response.body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");

    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/get-cart-products',
        body: {
          'username': email,
        });

    print(response.body);
    return jsonDecode(response.body);
  }

  sendProductsInfo() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String email = prefs.getString("email");
//    cartProducts = prefs.getStringList("cartProducts");
//    print('email');
//    print(email);
//    print(cartProducts);

//    http.Response response = await http.post(
//        'https://betasources.in/projects/grin-armer/cart-for-enquiry',
//        body: {
//          'username': email,
//          'products_ids': jsonEncode(cartProducts),
//        });
//
//    print(response.body);
//    var responseBody = jsonDecode(response.body);
//    if (responseBody['success'] == true) {
//      showSuccessDialog(
//          context, '            Order Placed.\nWe will contact you soon.');
//      cartProducts = [];
//      prefs.setStringList("cartProducts", cartProducts);
//      setState(() {
//        productIds = [];
//        count = [];
//      });
//    } else {
//      showErrConfirmDialog(context, responseBody['msg']);
//    }

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 30),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Please Wait..'),
          CircularProgressIndicator(
            backgroundColor: white,
            valueColor: AlwaysStoppedAnimation<Color>(appColor),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 3.0,
      backgroundColor: appColor,
    ));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");

    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/cart-for-enquiry',
        body: {
          'username': email,
        });

    print(response.body);
    var responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      prefs.setInt('cartItemCount', 0);
      _scaffoldKey.currentState.hideCurrentSnackBar();
      showSuccessDialog(context, responseBody['msg']);
      setState(() {});
    } else {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      showErrDialog(context, responseBody['msg']);
    }
  }

  //checker
  checker(productId) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "WARNING",
      content: Align(
        alignment: Alignment.center,
        child: Text(
          'Are you sure you want to remove the item?',
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      style: AlertStyle(
        animationType: AnimationType.shrink,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        descTextAlign: TextAlign.center,
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        titleStyle: TextStyle(
          color: Colors.orange,
        ),
        alertAlignment: Alignment.center,
      ),
      buttons: [
        DialogButton(
          // border: Border.all(width: 1.0),
          color: Colors.transparent,
          child: Text(
            "YES",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
          onPressed: () => removeProduct(productId),
          width: 120,
        ),
        DialogButton(
          // border: Border.all(width: 1.0, color: Colors.red),
          color: Colors.transparent,
          child: Text(
            "NO",
            style: TextStyle(color: mainColor, fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
    ).show();
  }

  //function to remove item from the cart
  removeProduct(productId) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    List products = prefs.getStringList('cartProducts');
//    print(products);
//
//    bool existsInCart = false;
//    products.every((m) {
//      m = jsonDecode(m);
//      var u = Cart.fromJson(m);
//      if (u.productId == productId) {
//        existsInCart = true;
//        print('exists');
//        products.removeWhere(
//            (item) => (Cart.fromJson(jsonDecode(item))).productId == productId);
//        // print(products);
//        prefs.setStringList('cartProducts', products);
//      }
//      if (existsInCart)
//        return false;
//      else
//        return true;
//    });
//    Navigator.pop(context);
//    setState(() {
//      productIds = [];
//      count = [];
//    });
//    if (existsInCart == false) {
//      print('does not exists');
//    }
//
//    List p = prefs.getStringList('cartProducts');
//    print(p);

    Navigator.pop(context);
//    showErrDialog(context, 'Loading..');
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 60),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Please Wait..'),
          CircularProgressIndicator(
            backgroundColor: white,
            valueColor: AlwaysStoppedAnimation<Color>(appColor),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 3.0,
      backgroundColor: appColor,
    ));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    int cartItemCount = prefs.getInt('cartItemCount');

    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/remove-from-cart',
        body: {
          'username': email,
          'product_id': productId.toString(),
        });

    print(response.body);
    var responseBody = jsonDecode(response.body);
//    Navigator.pop(context);
    if (responseBody['success'] == false) {
      setState(() {});
      _scaffoldKey.currentState.hideCurrentSnackBar();
      showErrDialog(context, responseBody['msg']);
    } else {
      print(cartItemCount);
      cartItemCount = cartItemCount - 1;
      print(cartItemCount);
      prefs.setInt('cartItemCount', (cartItemCount));
      print(responseBody['msg']);
      setState(() {});
      _scaffoldKey.currentState.hideCurrentSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductsWithRefProductIds(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: appColor,
              elevation: 2.0,
              centerTitle: true,
              title: Text(
                "My Cart",
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data.length.toString() + " Items",
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                snapshot.data.length == 0
                    ? Expanded(
                        child: Center(
                          child: Text('Cart is empty.'),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                  child: Container(
                                    color: Color(0xFFf5f6f7),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        // onTap: () {
                                        //   print('tapped');
                                        //   Widget okButton = FlatButton(
                                        //     child: Text("OK"),
                                        //     onPressed: () {},
                                        //   );

                                        //   // set up the AlertDialog
                                        //   AlertDialog alert = AlertDialog(
                                        //     title: IconButton(
                                        //       icon: Icon(Icons.arrow_left),
                                        //       onPressed: () {},
                                        //     ),
                                        //     content: PhotoViewGallery.builder(
                                        //       itemCount: imageList.length,
                                        //       builder: (context, index) {
                                        //         return PhotoViewGalleryPageOptions(
                                        //           imageProvider: AssetImage(
                                        //               imageList[index]),
                                        //           minScale:
                                        //               PhotoViewComputedScale
                                        //                       .contained *
                                        //                   0.8,
                                        //           maxScale:
                                        //               PhotoViewComputedScale
                                        //                       .covered *
                                        //                   2,
                                        //         );
                                        //       },
                                        //       scrollPhysics:
                                        //           BouncingScrollPhysics(),
                                        //       backgroundDecoration:
                                        //           BoxDecoration(
                                        //         color: Theme.of(context)
                                        //             .canvasColor,
                                        //       ),
                                        //       loadingBuilder:
                                        //           (context, event) => Center(
                                        //         child: Container(
                                        //           width: 20.0,
                                        //           height: 20.0,
                                        //           child:
                                        //               CircularProgressIndicator(
                                        //             value: event == null
                                        //                 ? 0
                                        //                 : event.cumulativeBytesLoaded /
                                        //                     event
                                        //                         .expectedTotalBytes,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   );

                                        //   // show the dialog
                                        //   showDialog(
                                        //     context: context,
                                        //     builder: (BuildContext context) {
                                        //       return alert;
                                        //     },
                                        //   );
                                        // },
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ZoomingImg(
                                                  img: snapshot.data[index]
                                                      ['images'][0],
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          // color: Colors.red,
                                          height: 125.0,
                                          width: 100.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(4.0),
                                            ),
                                            child: Image.network(
                                              snapshot.data[index]['images'][0],
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (context, child, progress) {
                                                return progress == null
                                                    ? child
                                                    : LinearProgressIndicator();
                                              },
                                            ),

                                            // Text("R"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        // height: 120,
                                        // color: Colors.blue,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      200,
                                                  child: Text(
                                                    snapshot.data[index]
                                                        ['product_name'],
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 4.0),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      200,
                                                  child: Text(
                                                    snapshot.data[index]
                                                        ['product_series'],
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Weight : "),
                                                    int.parse(snapshot
                                                                    .data[index]
                                                                ['pro_qty']) <
                                                            int.parse(snapshot
                                                                    .data[index]
                                                                ['qty'])
                                                        ? SizedBox(
                                                            height: 0,
                                                          )
                                                        : Text("Quantity : "),
                                                    // int.parse(count[index]) <
                                                    //         int.parse(
                                                    //             snapshot.data[index]
                                                    //                 ['pro_qty'])
                                                    //     ? Text("Quantity : ")
                                                    //     : SizedBox(
                                                    //         height: 0,
                                                    //       ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data[index]
                                                        ['weight']),
                                                    int.parse(snapshot
                                                                    .data[index]
                                                                ['pro_qty']) <
                                                            int.parse(snapshot
                                                                    .data[index]
                                                                ['qty'])
                                                        ? SizedBox(
                                                            height: 0,
                                                          )
                                                        : int.parse(snapshot
                                                                        .data[index]
                                                                    ['qty']) !=
                                                                0
                                                            ? Text(snapshot
                                                                    .data[index]
                                                                ['qty'])
                                                            : Text(""),
                                                    // int.parse(count[index]) <
                                                    //         int.parse(
                                                    //             snapshot.data[index]
                                                    //                 ['pro_qty'])
                                                    //     ? Text(count[index])
                                                    //     : SizedBox(
                                                    //         height: 0,
                                                    //       ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            int.parse(snapshot.data[index]
                                                        ['pro_qty']) ==
                                                    0
                                                ? Text(
                                                    "Out of Stock",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 20.0,
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 0,
                                                  ),
                                            // int.parse(count[index]) <
                                            //         int.parse(snapshot.data[index]
                                            //             ['pro_qty'])
                                            //     ? SizedBox(
                                            //         height: 0,
                                            //       )
                                            //     : Text(
                                            //         "Out of Stock",
                                            //         style: TextStyle(
                                            //           color: Colors.red,
                                            //           fontSize: 20.0,
                                            //         ),
                                            //       ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  height: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      height: 45.0,
                                      color: Colors.transparent,
                                      textColor: Colors.red,
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_forever_rounded),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 8.0,
                                            ),
                                          ),
                                          Text(
                                            'Remove',
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        checker(
                                            snapshot.data[index]['product_id']);
                                        // removeProduct(productIds[index]);
                                      },
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 1,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(bottom: 32.0),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                sendProductsInfo();
              },
              elevation: 4.0,
              tooltip: 'Checkout',
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: white,
              ),
              label: Text(
                "CHECKOUT",
                style: TextStyle(
                  color: white,
                ),
              ),
              backgroundColor: appColor,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              clipBehavior: Clip.none,
              // color: Colors.blue,
              shape: CircularNotchedRectangle(),
              child: Material(
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                ),
                color: white,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(
            child: Text('Server Error'),
          ));
        }
        return Scaffold(
          body: CustomLoader(),
        );
      },
    );
  }
}

// echo $product_ids[0]['productId']
