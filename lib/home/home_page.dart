import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:distributer_application/auth/showErrDialog.dart';
import 'package:distributer_application/base/custom_loader.dart';
import 'package:distributer_application/home/components/mushroom.dart';
import 'package:distributer_application/screens/about/about_page.dart';
import 'package:distributer_application/screens/about/tandc_page.dart';
import 'package:distributer_application/screens/account/account_page.dart';
import 'package:distributer_application/screens/account/http_json.dart';
// import 'package:distributer_application/screens/cart/demo.dart';
import 'package:distributer_application/screens/cart/mycart_page.dart';
import 'package:distributer_application/screens/order/orderHistory_page.dart';
import 'package:distributer_application/screens/order/salesmansOrder_page.dart';
import 'package:distributer_application/screens/products/all_products_page.dart';
import 'package:distributer_application/screens/products/product_description_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:distributer_application/auth/login_page.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/home/components/carousel.dart';
import 'package:distributer_application/home/components/grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/auth_page.dart';
import 'components/expansion_tile.dart';
import 'components/featured.dart';
import 'components/grid_card.dart';
import 'components/manual_json_serialization.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

const String bannersUrl =
    "https://betasources.in/projects/grin-armer/get-all-banners";
const String featuredUrl =
    "https://betasources.in/projects/grin-armer/get-featured-products";
const String categoryUrl =
    "https://betasources.in/projects/grin-armer/get-all-category";
const String userStatusUrl =
    "https://betasources.in/projects/grin-armer/get-user-status";

class HomePage extends StatefulWidget {
  final String email, name;

  HomePage({Key key, @required this.email, this.name}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(email, name);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final String email, name;

  _HomePageState(this.email, this.name);

  TabController tabController;
  String fetchedName = "";
  String userStatus;
  int cartItemCount;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var role;
  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fetchedName = prefs.getString("name");
    role = prefs.getString("role");
    print(fetchedName);
    return fetchedName;
  }

  //tabs for salesman products
  List<Tab> salesmanTabBars = [];
  List<Container> salesmanTabBarViews = [];
  Future<List<Tab>> getSalesmanProductsTabs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var referral = prefs.getString("referral");
    var role = prefs.getString("role");
    http.Response response = await http.post(
        "https://betasources.in/projects/grin-armer/salesman-products",
        body: {
          'referral': referral != null ? referral : '',
          'role': role != null ? role : '',
        });
//run karo
    print('products' + response.body);
    // print('Rohit');
    final responseBody = jsonDecode(response.body);
    // print(responseBody['success']);
    if (response.statusCode == 200) {
      if (responseBody.length > 0) {
        // final responseBody = jsonDecode(response.body);
        // tabController = TabController(length: responseBody.length, vsync: this);
        for (int i = 0; i < responseBody.length; i++) {
          // print('products' + responseBody[i]['cat_name']);
          salesmanTabBars.add(
            Tab(
              child: Container(
                // width: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: appColor, width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      responseBody[i]['cat_name'],
                      style: TextStyle(fontFamily: 'Livvic'),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        // List<dynamic> products;
        for (int i = 0; i < responseBody.length; i++) {
          List<dynamic> products = responseBody[i]['products'];
          // print("product" + i.toString());
          print(responseBody[i]['products'][0]['id']);
          print(products);
          salesmanTabBarViews.add(
            Container(
              color: white,
              padding: EdgeInsets.all(16.0),
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            orientation == Orientation.portrait ? 2 : 4,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    // scrollDirection: Axis.horizontal,
                    itemCount: responseBody[i]['products'].length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            userStatus == '0'
                                ? showInfoDialog(
                                    context, 'You are not verified by admin.')
                                : Navigator.of(context)
                                    .push(
                                    MaterialPageRoute(
                                        builder: (_) => ProductDescriptionPage(
                                              productId: products[index]['id'],
                                              productName: products[index]
                                                  ['product_name'],
                                              productSeries: products[index]
                                                  ['product_series'],
                                              productQty: products[index]
                                                  ['pro_qty'],
                                              categoryName: responseBody[i]
                                                  ['name'],
                                              // categorySeries: products[index][''],
                                              weight: products[index]['weight'],
                                              images: products[index]['images'],
                                            )),
                                  )
                                    .then((value) {
                                    setState(() {
                                      salesmanTabBars.clear();
                                      salesmanTabBarViews.clear();
                                    });
                                  });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GridTile(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0)),
                                  child: Image.network(
                                    products[index]['images'][0],
                                    fit: BoxFit.cover,
                                  ),
                                  // Text("R"),
                                )),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 8.0, left: 8.0),
                                  child: Column(
                                    children: [
                                      Divider(
                                        color: appColor,
                                        // height: 20,
                                        thickness: 1,
                                      ),
                                      Text(
                                        products[index]['product_name'],
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
                                        "Weight : " + products[index]['weight'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                          color: Colors.black,
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
                      );
                    },
                  );
                },
              ),
            ),
          );
        }
        return salesmanTabBars;
      } else {
        return [];
      }
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  Future<List<dynamic>> fetchBanners() async {
    http.Response response = await http.get(bannersUrl);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  Future fetchUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var referral = prefs.getString("referral");
    var role = prefs.getString("role");
    http.Response response =
        await http.post(userStatusUrl, body: {'username': email});

    if (response.statusCode == 200) {
      print(response.body);
      var responseBody = jsonDecode(response.body);
      userStatus = responseBody['isactive'];
      print(userStatus);
      print('referral code' + referral.toString());
      print('role' + role.toString());
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  Future<List<dynamic>> getSalesmanProducts() async {
    http.Response response = await http.get(bannersUrl);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  final style = TextStyle(
    color: white,
    fontWeight: FontWeight.bold,
  );

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.remove('email');
    prefs.remove('name');
    prefs.remove('role');
    prefs.remove('referral');
    if (prefs.getString('uid') == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    } else {
      prefs.remove('uid');
      signOutUser().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      });
    }
  }

  void confirmLogout() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "WARNING",
      content: Align(
        alignment: Alignment.center,
        child: Text(
          'Are you sure you want to logout?',
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
          onPressed: () => logout(),
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

  List<Tab> tabBars = [];
  List<Container> tabBarViews = [];

  Future<List<Tab>> getTabs() async {
    http.Response response = await http.get(
        "https://betasources.in/projects/grin-armer/get-recommended-category");

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      // tabController = TabController(length: responseBody.length, vsync: this);
      for (int i = 0; i < responseBody.length; i++) {
        tabBars.add(
          Tab(
            child: Container(
              // width: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: appColor, width: 1)),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    responseBody[i]['name'],
                    style: TextStyle(fontFamily: 'Livvic'),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      // List<dynamic> products;
      for (int i = 0; i < responseBody.length; i++) {
        List<dynamic> products = responseBody[i]['products'];
        // print("product" + i.toString());
        // print(products);
        tabBarViews.add(
          Container(
            color: white,
            padding: EdgeInsets.all(16.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: responseBody[i]['products'].length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: SizedBox(
                    width: 160, // put 190 for landscape
                    child: InkWell(
                      onTap: () {
                        userStatus == '0'
                            ? showInfoDialog(
                                context, 'You are not verified by admin.')
                            : Navigator.of(context)
                                .push(
                                MaterialPageRoute(
                                    builder: (_) => ProductDescriptionPage(
                                          productId: products[index]['id'],
                                          productName: products[index]
                                              ['product_name'],
                                          productSeries: products[index]
                                              ['product_series'],
                                          productQty: products[index]
                                              ['pro_qty'],
                                          categoryName: responseBody[i]['name'],
                                          // categorySeries: products[index][''],
                                          weight: products[index]['weight'],
                                          images: products[index]['images'],
                                        )),
                              )
                                .then((value) {
                                setState(() {
                                  tabBars.clear();
                                  tabBarViews.clear();
                                });
                              });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GridTile(
                                child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0)),
                              child: Image.network(
                                products[index]['images'][0],
                                fit: BoxFit.cover,
                              ),
                              // Text("R"),
                            )),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, right: 8.0, left: 8.0),
                              child: Column(
                                children: [
                                  Divider(
                                    color: appColor,
                                    // height: 20,
                                    thickness: 1,
                                  ),
                                  Text(
                                    products[index]['product_name'],
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
                                    "Weight : " + products[index]['weight'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: Colors.black,
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
              },
            ),
          ),
        );
      }
      return tabBars;
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  // List<Container> tabBarViews = [];
  // Future<List<Container>> getTabBarViews() async {
  //   http.Response response = await http.get(
  //       "https://betasources.in/projects/grin-armer//get-recommended-category");

  //   if (response.statusCode == 200) {
  //     final responseBody = jsonDecode(response.body);
  //     List<dynamic> products;
  //     for (int i = 0; i < responseBody.length; i++) {
  //       products = responseBody[i]['products'];
  //       print(products);
  //       tabBarViews.add(
  //         Container(
  //           padding: EdgeInsets.all(16.0),
  //           child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: responseBody[i]['products'].length,
  //             physics: BouncingScrollPhysics(),
  //             itemBuilder: (BuildContext context, int index) {
  //               return Card(
  //                 child: Container(
  //                   width: MediaQuery.of(context).size.width -
  //                       (MediaQuery.of(context).size.width / 2) -
  //                       25, // put 190 for landscape
  //                   child: InkWell(
  //                     onTap: () {
  //                       // print("tapped $products[index]['id']");
  //                     },
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Container(
  //                           height: 190.0,
  //                           color: Colors.red,
  //                           child: GridTile(
  //                               child: ClipRRect(
  //                             borderRadius: BorderRadius.only(
  //                                 topLeft: Radius.circular(4.0),
  //                                 topRight: Radius.circular(4.0)),
  //                             child:
  //                                 //              Image.network(
  //                                 //                entry.img,
  //                                 //                fit: BoxFit.cover,
  //                                 //              ),
  //                                 Text("R"),
  //                           )),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(
  //                             left: 8.0,
  //                             right: 8.0,
  //                           ),
  //                           child: Divider(
  //                             color: appColor,
  //                             // height: 20,
  //                             thickness: 1,
  //                           ),
  //                         ),
  //                         Center(
  //                           child: Padding(
  //                             padding: const EdgeInsets.only(
  //                                 bottom: 8.0, right: 8.0, left: 8.0),
  //                             child: Column(
  //                               children: [
  //                                 Text(
  //                                   products[index]['product_name'],
  //                                   maxLines: 1,
  //                                   overflow: TextOverflow.fade,
  //                                   softWrap: false,
  //                                   style: TextStyle(
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 12.0,
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: EdgeInsets.all(2.0),
  //                                 ),
  //                                 Text(
  //                                   "Weight : " + products[index]['weight'],
  //                                   maxLines: 1,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   softWrap: false,
  //                                   style: TextStyle(
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 12.0,
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
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //       // products.clear();
  //     }
  //     return tabBarViews;
  //   } else {
  //     throw Exception("Error, ${response.statusCode}");
  //   }
  // }

  Future<List<dynamic>> fetchFeatured() async {
    http.Response response = await http.get(featuredUrl);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  Future<List<dynamic>> fetchCategory() async {
    http.Response response = await http.get(categoryUrl);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  Future<List<dynamic>> getCartProductsCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");

    http.Response response = await http.post(
        'https://betasources.in/projects/grin-armer/get-cart-products',
        body: {
          'username': email,
        });

    print(response.body);
    cartItemCount = jsonDecode(response.body).length;
    prefs.setInt("cartItemCount", cartItemCount);

    var cic = prefs.getInt('cartItemCount');
    print('cartITemCunt' + cic.toString());

    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getName();
//    getTabs();
    // tabController = TabController(length: 1, vsync: this);
  }

  Future<void> fetchAll(context) async {
    return fetchUserStatus().then((value) {
      setState(() {
        print('RohitHere');
        tabBars.clear();
        tabBarViews.clear();
        salesmanTabBars.clear();
        salesmanTabBarViews.clear();
      });
    });
  }

  void refresh() {
    setState(() {
      tabBars.clear();
      tabBarViews.clear();
      salesmanTabBars.clear();
      salesmanTabBarViews.clear();
    });
  }

  void navigate(pageRoute) {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(
      MaterialPageRoute(builder: (_) => pageRoute),
    )
        .then((value) {
      setState(() {
        tabBars.clear();
        tabBarViews.clear();
        salesmanTabBars.clear();
        salesmanTabBarViews.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () => fetchAll(context),
        color: appColor,
        strokeWidth: 3.0,
        key: _refreshIndicatorKey,
        child: FutureBuilder(
          future: Future.wait([
            getName(),
            fetchBanners(),
            fetchFeatured(),
            fetchCategory(),
            getTabs(),
            fetchUserStatus(),
            getCartProductsCount(),
            getSalesmanProductsTabs(),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data[3]);
              return Scaffold(
                backgroundColor: white,
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0.0,
                  title: Image.asset(
                    'assets/GrinArmerLogo.png',
                    height: 55.0,
                  ),
                  // iconTheme: IconThemeData(
                  //   color: appColor,
                  // ),
                  // Image(
                  //   image: NetworkImage(
                  //       'https://bulkorders.thesouledstore.com/static/images/logo.png'),
                  //   height: 48.0,
                  // ),
                  backgroundColor: Colors.transparent,
                  actions: [
                    // role == '1'
                    //     ? SizedBox(
                    //         height: 0,
                    //       )
                    //     :
                    IconButton(
                      icon: Icon(Icons.refresh_rounded),
                      tooltip: 'Refresh',
                      onPressed: () {
                        Text('Loading');
                        _refreshIndicatorKey.currentState.show();
                        // fetchAll(context);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12.0),
                        child: Badge(
                          badgeContent: Text(
                            snapshot.data[6].length.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: white,
                            ),
                          ),
                          child: Icon(Icons.shopping_cart_outlined),
                          animationType: BadgeAnimationType.slide,
                          badgeColor: appColor,
                        ),
                      ),
                      onTap: () {
                        userStatus == '0'
                            ? showInfoDialog(
                                context, 'You are not verified by admin.')
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyCartPage(),
                                ),
                              ).then((value) {
                                setState(() {
                                  tabBars.clear();
                                  tabBarViews.clear();
                                  salesmanTabBars.clear();
                                  salesmanTabBarViews.clear();
                                });
                              });
                      },
                    ),
                  ],
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Image(
                                //   image: NetworkImage(
                                //       'https://bulkorders.thesouledstore.com/static/images/logo.png'),
                                //   height: 48.0,
                                // ),
                                Image.asset(
                                  'assets/GrinArmerLogo.png',
                                  height: 80.0,
                                ),
                                // OutlineButton(
                                //   child: Text(
                                //     email + "  >",
                                //     style: TextStyle(fontSize: 12.0),
                                //   ),
                                //   onPressed: () {
                                //     Navigator.of(context)
                                //         .push(MaterialPageRoute(builder: (_) => LoginPage()));
                                //   },
                                //   highlightElevation: 8.0,
                                //   borderSide: BorderSide(color: Colors.transparent),
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(2.0)),
                                // ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    navigate(
                                      AccountPage(
                                        email: email,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    email,
                                    style: TextStyle(
                                      // color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                      ExpansionTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.dashboard_outlined,
                            //auto_awesome_motion
                            color: appColor,
                          ),
                        ),
                        title: Text('Categories'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: DynamicExpansionTileList(snapshot.data[3],
                                userStatus, refresh, cartItemCount),
                          ),
                        ],
                      ),
                      // ListTile(
                      //   title: Text("Demo"),
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(builder: (_) => Demo()),
                      //     );
                      //   },
                      // ),
                      // ListTile(
                      //   title: Text("Product Description"),
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(
                      //           builder: (_) => ProductDescriptionPage()),
                      //     );
                      //   },
                      // ),
                      // ListTile(
                      //   title: Text("FAQ"),
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(builder: (_) => HtmlJson()),
                      //     );
                      //   },
                      // ),
                      // ListTile(
                      //   title: Text("Contact Us"),
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(builder: (_) => HomeScreen()),
                      //     );
                      //   },
                      // ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: appColor,
                          ),
                        ),
                        title: Text("My Cart"),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () {
                          userStatus == '0'
                              ? showInfoDialog(
                                  context, 'You are not verified by admin.')
                              : navigate(
                                  MyCartPage(),
                                );
                        },
                      ),
                      role == '1'
                          ? ListTile(
                              leading: CircleAvatar(
                                child: Icon(
                                  Icons.shopping_basket_outlined,
                                  color: appColor,
                                ),
                              ),
                              title: Text("Salesmans Order"),
                              trailing: Icon(Icons.chevron_right_rounded),
                              onTap: () {
                                userStatus == '0'
                                    ? showInfoDialog(context,
                                        'You are not verified by admin.')
                                    : navigate(
                                        SalesmansOrder(),
                                      );
                              },
                            )
                          : SizedBox(height: 0),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.history,
                            color: appColor,
                          ),
                        ),
                        title: Text("Order History"),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () {
                          userStatus == '0'
                              ? showInfoDialog(
                                  context, 'You are not verified by admin.')
                              : navigate(
                                  OrderHistoryPage(),
                                );
                        },
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.person_outline,
                            color: appColor,
                          ),
                        ),
                        title: Text("Profile"),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () {
                          navigate(
                            AccountPage(
                              email: email,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: CircleAvatar(
                            child: Icon(
                          Icons.info_outline_rounded,
                          color: appColor,
                        )),
                        title: Text("About"),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () {
                          navigate(
                            AboutPage(),
                          );
                        },
                      ),
                      ListTile(
                        leading: CircleAvatar(
                            child: Icon(
                          Icons.logout,
                          color: appColor,
                        )),
                        title: Text("Logout"),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () {
                          confirmLogout();
                        },
                      ),
                      // Divider(
                      //   color: Colors.grey[300],
                      //   height: 1,
                      //   // thickness: 1,
                      // ),
                    ],
                  ),
                ),
                body: role == '1'
                    ? Container(
                        color: white,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              role == '1'
                                  ? SizedBox(
                                      height: 250.0,
                                      child: Swiper(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CachedNetworkImage(
                                            imageUrl: snapshot.data[1][index]
                                                ["image"],
                                            // progressIndicatorBuilder: (context, url,
                                            //         downloadProgress) =>
                                            //     CircularProgressIndicator(
                                            //         value: downloadProgress.progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        autoplay: true,
                                        itemCount: snapshot.data[1].length,
                                        scrollDirection: Axis.horizontal,
                                        pagination: SwiperPagination(
                                            alignment: Alignment.bottomCenter),
                                        // control: SwiperControl(),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              role == '1'
                                  ? SizedBox(
                                      height: 10,
                                      child: Container(
                                        color: Color(0xFFf5f6f7),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              role == '1'
                                  ? SizedBox(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 2.0, left: 16.0),
                                        child: Text(
                                          "Featured",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              role == '1'
                                  ? SizedBox(
                                      height: 325.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Swiper(
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              child: InkWell(
                                                onTap: () {
                                                  userStatus == '0'
                                                      ? showInfoDialog(context,
                                                          'You are not verified by admin.')
                                                      : Navigator.of(context)
                                                          .push(
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                ProductDescriptionPage(
                                                              productId: snapshot
                                                                          .data[
                                                                      2][index][
                                                                  'product_id'],
                                                              productName: snapshot
                                                                          .data[
                                                                      2][index][
                                                                  'product_name'],
                                                              productSeries:
                                                                  snapshot.data[
                                                                              2]
                                                                          [
                                                                          index]
                                                                      [
                                                                      'product_series'],
                                                              productQty: snapshot
                                                                          .data[
                                                                      2][index][
                                                                  'product_quantity'],
                                                              categoryName:
                                                                  snapshot.data[
                                                                              2][
                                                                          index]
                                                                      [
                                                                      'cat_name'],
                                                              // categorySeries: products[index][''],
                                                              weight: snapshot
                                                                          .data[
                                                                      2][index]
                                                                  ['weight'],
                                                              images: snapshot
                                                                          .data[
                                                                      2][index]
                                                                  ['images'],
                                                            ),
                                                          ),
                                                        )
                                                          .then((value) {
                                                          setState(() {
                                                            tabBars.clear();
                                                            tabBarViews.clear();
                                                            salesmanTabBars
                                                                .clear();
                                                            salesmanTabBarViews
                                                                .clear();
                                                          });
                                                        });
                                                },
                                                child: Card(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                          child: Image.network(
                                                            snapshot.data[2]
                                                                    [index]
                                                                ["images"][0],
                                                            fit: BoxFit.cover,
                                                          ),
                                                          // Text("R"),
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.only(
                                                      //     left: 8.0,
                                                      //     right: 8.0,
                                                      //   ),
                                                      //   child: Divider(
                                                      //     color: appColor,
                                                      //     // height: 20,
                                                      //     thickness: 1,
                                                      //   ),
                                                      // ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                snapshot.data[2]
                                                                        [index][
                                                                    'product_name'],
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                softWrap: false,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12.0,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            2.0),
                                                              ),
                                                              Text(
                                                                'Weight : ' +
                                                                    snapshot.data[2]
                                                                            [
                                                                            index]
                                                                        [
                                                                        'weight'],
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                                style:
                                                                    TextStyle(
                                                                  color: grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                  // ClipRRect(
                                                  //   borderRadius: BorderRadius.circular(4.0),
                                                  //   child:
                                                  //   Container(
                                                  //     decoration: BoxDecoration(
                                                  //       image: DecorationImage(
                                                  //         image: NetworkImage(snapshot.data[2]
                                                  //             [index]["images"][0]),
                                                  //         fit: BoxFit.cover,
                                                  //       ),
                                                  //     ),
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.all(8.0),
                                                  //       child: Column(
                                                  //         mainAxisAlignment:
                                                  //             MainAxisAlignment.end,
                                                  //         children: [
                                                  //           Text(
                                                  //             "Name : " +
                                                  //                 snapshot.data[2][index]
                                                  //                     ["product_name"],
                                                  //             style: style,
                                                  //           ),
                                                  //           Text(
                                                  //             "Weight : " +
                                                  //                 snapshot.data[2][index]
                                                  //                     ["weight"],
                                                  //             style: style,
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: snapshot.data[2].length,
                                          // autoplay: true,
                                          outer: true,
                                          viewportFraction: 0.8,
                                          scale: 0.9,
                                          // layout: SwiperLayout.CUSTOM,
                                          // customLayoutOption: new CustomLayoutOption(startIndex: -1, stateCount: 3)
                                          //     .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
                                          //   new Offset(-370.0, -40.0),
                                          //   new Offset(0.0, 0.0),
                                          //   new Offset(370.0, -40.0)
                                          // ]),
                                          // itemWidth: 300,
                                          pagination: SwiperPagination(
                                              builder:
                                                  DotSwiperPaginationBuilder(
                                                      color: Colors.grey[400],
                                                      size: 6.0,
                                                      activeColor: Colors.black,
                                                      activeSize: 8.0)),
                                          // control: SwiperControl(),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              role == '1'
                                  ? SizedBox(
                                      height: 10,
                                      child: Container(
                                        color: Color(0xFFf5f6f7),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              // SizedBox(
                              //   child: Padding(
                              //     padding: EdgeInsets.only(
                              //         top: 10.0, bottom: 8.0, left: 16.0),
                              //     child: Text(
                              //       "Recommended",
                              //       style: TextStyle(
                              //           fontSize: 18.0, fontWeight: FontWeight.bold),
                              //     ),
                              //   ),
                              // ),
                              role == '1'
                                  ? SizedBox(
                                      height: 400,
                                      child: DefaultTabController(
                                        length: tabBars.length,
                                        child: Scaffold(
                                          appBar: AppBar(
                                            title: Text(
                                              "Recommended",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            elevation: 0.0,
                                            backgroundColor: white,
                                            bottom: TabBar(
                                              tabs: tabBars,
                                              labelStyle:
                                                  TextStyle(fontSize: 12.0),
                                              unselectedLabelStyle: TextStyle(
                                                fontSize: 11.0,
                                              ),
                                              labelColor: white,
                                              isScrollable: true,
                                              unselectedLabelColor: black,
                                              indicatorSize:
                                                  TabBarIndicatorSize.label,
                                              indicator: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: appColor),
                                            ),
                                          ),
                                          body: Container(
                                            child: TabBarView(
                                              children: tabBarViews,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),

                              // DefaultTabController(
                              //   length: 2,
                              //   child: SizedBox(
                              //     height: 350,
                              //     child: Column(
                              //       children: [
                              //         SizedBox(
                              //           height: 50.0,
                              //           child: AppBar(
                              //             elevation: 0.0,
                              //             backgroundColor: white,
                              //             bottom: TabBar(
                              //               tabs: tabBars,
                              //               labelStyle: TextStyle(fontSize: 16.0),
                              //               unselectedLabelStyle: TextStyle(
                              //                 fontSize: 14.0,
                              //               ),
                              //               labelColor: white,
                              //               isScrollable: true,
                              //               controller: tabController,
                              //               unselectedLabelColor: black,
                              //               indicatorSize: TabBarIndicatorSize.label,
                              //               indicator: BoxDecoration(
                              //                   borderRadius: BorderRadius.circular(50),
                              //                   color: appColor),
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           height: 300.0,
                              //           child: TabBarView(
                              //             children: tabBarViews,
                              //             // controller: tabController,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        // height: 400,
                        child: DefaultTabController(
                          length: salesmanTabBars.length,
                          child: Scaffold(
                            appBar: AppBar(
                              title: Text(
                                "All Products",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              centerTitle: true,
                              elevation: 0.0,
                              backgroundColor: white,
                              bottom: TabBar(
                                tabs: salesmanTabBars,
                                labelStyle: TextStyle(fontSize: 12.0),
                                unselectedLabelStyle: TextStyle(
                                  fontSize: 11.0,
                                ),
                                labelColor: white,
                                isScrollable: true,
                                unselectedLabelColor: black,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: appColor),
                              ),
                            ),
                            body: Container(
                              child: TabBarView(
                                // physics: NeverScrollableScrollPhysics(),
                                children: salesmanTabBarViews,
                              ),
                            ),
                          ),
                        ),
                      ),
              );
            } else if (snapshot.hasError) {
              Scaffold(
                body: Center(
                  child: Text('Server Error'),
                ),
              );
            }
            return Scaffold(
              body: CustomLoader(),
            );
          },
        ),
//             : FutureBuilder(
//                 future: getTabs(),
//                 builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//                   if (snapshot.hasData) {
//                     return Scaffold(

//                     );
//                   }
//                   if(snapshot.hasError){
        // return
//                   }
//                   return
//                 },
//               ),
      ),
    );
  }
}
