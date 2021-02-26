import 'dart:convert';

import 'package:distributer_application/auth/showErrDialog.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/base/zoomingImg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_product_management.dart';

class ProductDescriptionPage extends StatefulWidget {
  final String productId,
      productName,
      productSeries,
      productQty,
      categoryName,
      categorySeries,
      weight;
  final List<dynamic> images;
  ProductDescriptionPage({
    Key key,
    @required this.productId,
    @required this.productName,
    @required this.productSeries,
    @required this.productQty,
    @required this.categoryName,
    this.categorySeries,
    @required this.weight,
    this.images,
  }) : super(key: key);
  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState(
        productId,
        productName,
        productSeries,
        productQty,
        categoryName,
        categorySeries,
        weight,
        images,
      );
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  static int count = 1;

  final String productId,
      productName,
      productSeries,
      productQty,
      categoryName,
      categorySeries,
      weight;
  final List<dynamic> images;
  _ProductDescriptionPageState(
    this.productId,
    this.productName,
    this.productSeries,
    this.productQty,
    this.categoryName,
    this.categorySeries,
    this.weight,
    this.images,
  );

  // Add to Cart operations
  //add products into the cart => initial/new
  addProductId(productId, count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> products;

    products = prefs.getStringList("cartProducts");
    print(products);

    Cart c = Cart(productId, count.toString());
    String p = jsonEncode(c);
    products.add(p);
    print(products);

    prefs.setStringList("cartProducts", products);
    showSuccessDialog(context, 'Item added successfully.');
  }

  //update the product in the cart
  updateProduct(productId, count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List products;

    products = prefs.getStringList('cartProducts');
    // products.clear();
    // prefs.setStringList('cartProducts', products);
    // products = prefs.getStringList('cartProducts');
    // print(products);

    bool existsInCart = false;

    products.every((m) {
      m = jsonDecode(m);
      var u = Cart.fromJson(m);
      if (u.productId == productId) {
        existsInCart = true;
        var previousCount = u.count;
        products.removeWhere(
            (item) => (Cart.fromJson(jsonDecode(item))).productId == productId);
        Cart c = Cart(productId, (count + int.parse(previousCount)).toString());
        String p = jsonEncode(c);
        products.add(p);
        prefs.setStringList('cartProducts', products);
        products = prefs.getStringList('cartProducts');
        print(products);
        showSuccessDialog(context, 'Item added successfully.');
      }
      if (existsInCart)
        return false;
      else
        return true;
    });
    if (existsInCart == false) {
      print('does not exists');
    }
  }

  //main function to instatiate addtocart or updatecart operation
  doProductManagement(productId, count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List products;
    products = prefs.getStringList('cartProducts');
    print(products);

    bool existsInCart = false;

    products == null ?? prefs.setStringList("cartProducts", []);

    products != []
        ? products.every((m) {
            m = jsonDecode(m);
            var u = Cart.fromJson(m);
            if (u.productId == productId) {
              existsInCart = true;
              (int.parse(u.count) + count) > int.parse(productQty)
                  ? showErrDialog(context, 'Product limit exceeded.')
                  : updateProduct(productId, count);
            }
            if (existsInCart)
              return false;
            else
              return true;
          })
        : addProductId(productId, count);
    if (existsInCart == false) {
      addProductId(productId, count);
    }
  }

  //function to remove item from the cart
  removeProduct(productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.setStringList("cartProducts", []);

    List products = prefs.getStringList('cartProducts');

    print(products);
    bool existsInCart = false;
    products.every((m) {
      m = jsonDecode(m);
      var u = Cart.fromJson(m);
      if (u.productId == productId) {
        existsInCart = true;
        print('exists');
        products.removeWhere(
            (item) => (Cart.fromJson(jsonDecode(item))).productId == productId);
        // print(products);
        prefs.setStringList('cartProducts', products);
      }
      if (existsInCart)
        return false;
      else
        return true;
    });
    if (existsInCart == false) {
      print('does not exists');
    }

    List p = prefs.getStringList('cartProducts');
    print(p);
  }

  List cartProducts;
  void getSPData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartProducts = prefs.getStringList('cartProducts');
  }

  //add function
  void add() {
    bool existsInCart = false;
    cartProducts != [] ??
        cartProducts.every((m) {
          m = jsonDecode(m);
          var u = Cart.fromJson(m);
          if (u.productId == productId) {
            existsInCart = true;
            (int.parse(u.count) + count) > int.parse(productQty)
                ? showErrDialog(context, 'Product limit exceeded')
                : setState(() {
                    if (count < int.parse(productQty)) count++;
                  });
          }
          if (existsInCart)
            return false;
          else
            return true;
        });

    if (existsInCart == false) {
      setState(() {
        if (count < int.parse(productQty)) count++;
      });
    }
  }

  //minus function
  void minus() {
    setState(() {
      if (count != 1) count--;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 1;
    getSPData();
  }

  final headingStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  final subheadingStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.grey[700],
  );

  Widget divider = Divider(
    height: 1.0,
  );

  Widget separatorPadding = Padding(padding: EdgeInsets.all(10.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 2.0,
        centerTitle: true,
        title: Text(
          productName,
          style: TextStyle(
            color: white,
          ),
        ),
        iconTheme: IconThemeData(
          color: white,
        ),
//        bottom: PreferredSize(
//          child: Container(
//            color: appColor,
//            height: 1.5,
//          ),
//          preferredSize: Size.fromHeight(4.0),
//        ),
      ),
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 400.0,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ZoomingImg(
                                      img: images[index],
                                    ),
                                  ));
                            },
                            child: Card(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: images.length,
                      outer: true,
                      viewportFraction: 1,
                      scale: 0.9,
                      loop: images.length > 1 ? true : false,
                      control: images.length > 1
                          ? SwiperControl(
                              color: white,
                            )
                          : null,
                      pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                            color: Colors.grey[400],
                            size: 6.0,
                            activeColor: appColor,
                            activeSize: 8.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: Card(
                      elevation: 0.5,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 12.0, right: 10.0, left: 10.0, bottom: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: appColor,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(6.0)),
                            SizedBox(
                              height: 5,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                color: Color(0xFFf5f6f7),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(8.0)),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Category : ",
                                                style: headingStyle,
                                              ),
                                              separatorPadding,
                                              Text(
                                                "P Series : ",
                                                style: headingStyle,
                                              ),
                                              separatorPadding,
                                              Text(
                                                "C Series : ",
                                                style: headingStyle,
                                              ),
                                              separatorPadding,
                                              Text(
                                                "Weight : ",
                                                style: headingStyle,
                                              ),
                                              separatorPadding,
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "categoryName",
                                                style: subheadingStyle,
                                              ),
                                              separatorPadding,
                                              Text(
                                                productSeries,
                                                style: subheadingStyle,
                                              ),
                                              separatorPadding,
                                              Text(
                                                categorySeries == null
                                                    ? ''
                                                    : categorySeries,
                                                style: subheadingStyle,
                                              ),
                                              separatorPadding,
                                              Text(weight,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: subheadingStyle),
                                              separatorPadding,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // int.parse(productQty) <= 10
                                  //     ? Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.end,
                                  //         children: [
                                  //           Container(
                                  //               decoration: BoxDecoration(
                                  //                   color: Colors.red,
                                  //                   border: Border.all(
                                  //                       color: Colors.red),
                                  //                   borderRadius:
                                  //                       BorderRadius.all(
                                  //                     Radius.circular(50.0),
                                  //                   )),
                                  //               width:
                                  //                   36.0, //we have change width according to items left(same as count below)
                                  //               child: Padding(
                                  //                 padding: EdgeInsets.all(8.0),
                                  //                 child: Center(
                                  //                   child: Text(
                                  //                     productQty,
                                  //                     style: TextStyle(
                                  //                       color: Colors.white,
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                       fontSize: 12.0,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               )),
                                  //           Padding(
                                  //             padding:
                                  //                 EdgeInsets.only(bottom: 8.0),
                                  //           ),
                                  //           Text(
                                  //             "Piece(s) left",
                                  //             style: TextStyle(
                                  //               color: Colors.red,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 12.0,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     : Container(
                                  //         color: grey,
                                  //         child: Column(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.end,
                                  //           children: [
                                  //             Text(
                                  //               "Instock",
                                  //               style: TextStyle(
                                  //                 color: appColor,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 fontSize: 12.0,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                color: Color(0xFFf5f6f7),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Quantity : ",
                                      style: headingStyle,
                                    ),
                                    FloatingActionButton(
                                      heroTag: null,
                                      onPressed: minus,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 16.0,
                                        ),
                                        child: Icon(
                                          Icons.minimize_rounded,
                                          color: appColor,
                                        ),
                                      ),
                                      elevation: 4.0,
                                      backgroundColor: white,
                                      mini: true,
                                    ),
                                    Container(
                                      width: count > 99 ? 75.0 : 50.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[700],
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50.0),
                                          )),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text('$count',
                                              style: new TextStyle(
                                                  fontSize: 20.0)),
                                        ),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      heroTag: null,
                                      onPressed: add,
                                      child: new Icon(
                                        Icons.add,
                                        color: appColor,
                                      ),
                                      elevation: 4.0,
                                      backgroundColor: white,
                                      mini: true,
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: int.parse(productQty) <= 10
                  ? FloatingActionButton(
                      onPressed: () {},
                      heroTag: null,
                      tooltip: 'Piece(s) Left',
                      mini: true,
                      child: Text(
                        productQty,
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    )
                  : FloatingActionButton(
                      onPressed: () {},
                      heroTag: null,
                      tooltip: 'Instock',
                      mini: true,
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: white,
                      ),
                      backgroundColor: appColor,
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // addProductId(productId, count);
          // removeProduct(productId);
          // updateProduct(productId, count);
          doProductManagement(productId, count);
        },
        elevation: 4.0,
        tooltip: 'Add to cart',
        icon: Icon(
          Icons.add,
          color: white,
        ),
        label: Text(
          "ADD TO CART",
          style: TextStyle(
            color: white,
          ),
        ),
        backgroundColor: appColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         child: Row(
// //          mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // FlatButton(
//             //   color: appColor,
//             //   textColor: Colors.white,
//             //   disabledColor: Colors.grey,
//             //   disabledTextColor: Colors.black,
//             //   padding: EdgeInsets.all(12.0),
//             //   splashColor: Colors.greenAccent,
//             //   minWidth: MediaQuery.of(context).size.width - 100,
//             //   onPressed: () {
//             //     /*...*/
//             //   },
//             //   child: Text(
//             //     "ADD TO CART",
//             //     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//             //   ),
//             // ),
//             FloatingActionButton.extended(
//               icon: Icon(Icons.add),
//               label: Text("ADD TO CART"),
//               onPressed: () {},
//             ),
//             Padding(padding: EdgeInsets.only(bottom: 16.0)),
//           ],
//         ),
//       ),
    );
  }
}
