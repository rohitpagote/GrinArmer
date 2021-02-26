import 'package:carousel_pro/carousel_pro.dart';
import 'package:distributer_application/home/components/featured.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:distributer_application/auth/login_page.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:distributer_application/home/components/carousel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabController controller;
  @override
  Widget build(BuildContext context) {
    Widget men = (ExpansionTile(
      title: Text('Men'),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('T-shirts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Drop Cut T-shirts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Full Sleeve T-shirts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Polos'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Shirts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ));

    Widget women = (ExpansionTile(
      title: Text('Women'),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('T-shirts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Dresses'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Tank Tops'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Hoodies/Sweatshirts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Jackets'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Image(
          image: NetworkImage(
              'https://bulkorders.thesouledstore.com/static/images/logo.png'),
          height: 48.0,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Icon(Icons.notifications_on_outlined),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: NetworkImage(
                        'https://bulkorders.thesouledstore.com/static/images/logo.png'),
                    height: 48.0,
                  ),
                  OutlineButton(
                    child: Text("Login/Register"),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    highlightElevation: 8.0,
                    borderSide: BorderSide(color: mainColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            men,
            women,
            ListTile(
              title: Text("FAQ"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Contact Us"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Terms and Conditions"),
              onTap: () {},
            )
          ],
        ),
      ),
      body:
          // SingleChildScrollView(
          //         child: SafeArea(
          //     child: Container(
          //       child: Column(
          //         children: [
          //           SizedBox(
          //             height: 450.0,
          //             width: MediaQuery.of(context).size.width,
          //             child: Carousel(
          //               boxFit: BoxFit.cover,
          //               autoplay: true,
          //               autoplayDuration: Duration(milliseconds: 5000),
          //               animationCurve: Curves.fastOutSlowIn,
          //               animationDuration: Duration(milliseconds: 1000),
          //               dotSize: 6.0,
          //               // dotIncreasedColor: Color(0xFFFF335C),
          //               dotBgColor: Colors.transparent,
          //               dotPosition: DotPosition.bottomCenter,
          //               dotVerticalPadding: 10.0,
          //               showIndicator: true,
          //               indicatorBgPadding: 7.0,
          //               images: [
          //                 NetworkImage(
          //                     'https://image.freepik.com/free-photo/full-length-portrait-happy-girl-with-boombox_171337-3250.jpg'),
          //                 NetworkImage(
          //                     'https://image.freepik.com/free-photo/attractive-happy-funny-woman-dancing-listening-music-headphones-dressed-hipster-colorful-style-outfit-isolated-pink-studio-background_285396-7232.jpg'),
          //                 NetworkImage(
          //                     "https://image.freepik.com/free-photo/portrait-man-dancing_23-2148666506.jpg"),
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //             child: Container(
          //               color: Color(0xFFf5f6f7),
          //             ),
          //           ),
          //           PreferredSize(
          //             preferredSize: Size.fromHeight(50.0),
          //             child: DefaultTabController(
          //               length: 3,
          //               child: TabBar(
          //                 controller: controller,
          //                 labelColor: Colors.black,
          //                 tabs: [
          //                   Tab(
          //                     text: 'Categories',
          //                   ),
          //                   Tab(
          //                     text: 'Brands',
          //                   ),
          //                   Tab(
          //                     text: 'Shops',
          //                   )
          //                 ], // list of tabs
          //               ),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //             child: Container(
          //               color: Color(0xFFf5f6f7),
          //             ),
          //           ),
          //           // PreferredSize(
          //           //   preferredSize: Size.fromHeight(50),
          //           //                   child: DefaultTabController(
          //           //                     length: 3,
          //           //                     child: TabBarView(
          //           //                       children: [
          //           //                         Container(
          //           //                           color: Colors.white24,
          //           //                           child: Text("data"),
          //           //                         ),
          //           //                         Container(
          //           //                           color: Colors.white24,
          //           //                           child: Text("data"),
          //           //                         ),
          //           //                         Container(
          //           //                           color: Colors.white24,
          //           //                           child: Text("data"),
          //           //                         ) // class name
          //           //                       ],
          //           //                     ),
          //           //                   ),
          //           // ),
          //           PreferredSize(
          //             preferredSize: Size.fromHeight(50.0),
          //             child: DefaultTabController(
          //               length: 3,
          //               child: TabBar(
          //                 controller: controller,
          //                 labelColor: Colors.black,
          //                 tabs: [
          //                   Tab(
          //                     text: 'Categories',
          //                   ),
          //                   Tab(
          //                     text: 'Brands',
          //                   ),
          //                   Tab(
          //                     text: 'Shops',
          //                   )
          //                 ], // list of tabs
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // slivers: [
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 450.0,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselComponent(), //import from carousel.dart file
                  ),
                  SizedBox(
                    height: 10,
                    child: Container(
                      color: Color(0xFFf5f6f7),
                    ),
                  ),
                  // PreferredSize(
                  //   preferredSize: Size.fromHeight(50.0),
                  //   child: DefaultTabController(
                  //     length: 3,
                  //     child: TabBar(
                  //       controller: controller,
                  //       labelColor: Colors.black,
                  //       tabs: [
                  //         Tab(
                  //           text: 'Categories',
                  //         ),
                  //         Tab(
                  //           text: 'Brands',
                  //         ),
                  //         Tab(
                  //           text: 'Shops',
                  //         )
                  //       ], // list of tabs
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  //   child: Container(
                  //     color: Color(0xFFf5f6f7),
                  //   ),
                  // ),
                ],
              ),
            ),
            // SliverGrid(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       childAspectRatio: 1.0,
            //       mainAxisSpacing: 4.0,
            //       crossAxisSpacing: 4.0),
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return Card(
            //         child: Container(
            //             padding: EdgeInsets.all(32.0),
            //             child: Image(
            //               image: NetworkImage(
            //                   "https://image.freepik.com/free-photo/man-portrait_1296-626.jpg"),
            //             )),
            //       );
            //     },
            //     childCount: 4,
            //   ),
            // ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 10.0, left: 12.0),
              sliver: SliverToBoxAdapter(
                  child: Text(
                "Categories",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
            ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 300,
            //     child: GridView.count(
            //       scrollDirection: Axis.horizontal,
            //       primary: false,
            //       padding: const EdgeInsets.all(20),
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 10,
            //       crossAxisCount: 2,
            //       children: [
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           child: const Text("He'd have you all unravel at the"),
            //           color: Colors.teal[100],
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           child: const Text('Heed not the rabble'),
            //           color: Colors.teal[200],
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           child: const Text('Sound of screams but the'),
            //           color: Colors.teal[300],
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           child: const Text('Who scream'),
            //           color: Colors.teal[400],
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           child: const Text('Revolution is coming...'),
            //           color: Colors.teal[500],
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           child: const Text('Revolution, they...'),
            //           color: Colors.teal[600],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 340,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: GridTile(
                            footer: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Hii there",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                image: NetworkImage(
                                    "https://image.freepik.com/free-vector/disco-party-people-dancing-club-having-fun-nightclub-nightlife-discoteque-clubbing-female-dj-cartoon-character-music-concert-vector-isolated-concept-metaphor-illustration_335657-1286.jpg"),
                                fit: BoxFit.cover,
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ),
            ),
            // SliverPadding(
            //   padding: const EdgeInsets.all(8.0),
            //   sliver: SliverGrid.count(
            //     childAspectRatio: 1.0,
            //     crossAxisSpacing: 4,
            //     mainAxisSpacing: 4,
            //     crossAxisCount: 2,
            //     // Generate 100 widgets that display their index in the List.
            //     children: List.generate(6, (index) {
            //       return InkWell(
            //         onTap: () {
            //           print('$index');
            //           // use this line if you want to pass index position on the next page
            //           Navigator.of(context)
            //               .pushNamed('YOUR_PAGE', arguments: '$index');
            //           //or if you don't want to pass anything use this
            //           Navigator.of(context).pushNamed('YOUR_PAGE');
            //         },
            //         child: Card(
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(4.0),
            //             child: Image(
            //               image: NetworkImage(
            //                   "https://image.freepik.com/free-photo/man-portrait_1296-626.jpg"),
            //               fit: BoxFit.fitWidth,
            //             ),
            //           ),
            //         ),
            //       );
            //     }),
            //   ),
            // ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 0.0),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                  child: Container(
                    color: Color(0xFFf5f6f7),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 10.0, left: 12.0),
              sliver: SliverToBoxAdapter(
                  child: Text(
                "New Arrivals",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FeaturedComponent(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    child: Container(
                      color: Color(0xFFf5f6f7),
                    ),
                  ),
                  // PreferredSize(
                  //   preferredSize: Size.fromHeight(50.0),
                  //   child: DefaultTabController(
                  //     length: 3,
                  //     child: TabBar(
                  //       controller: controller,
                  //       labelColor: Colors.black,
                  //       tabs: [
                  //         Tab(
                  //           text: 'Categories',
                  //         ),
                  //         Tab(
                  //           text: 'Brands',
                  //         ),
                  //         Tab(
                  //           text: 'Shops',
                  //         )
                  //       ], // list of tabs
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  //   child: Container(
                  //     color: Color(0xFFf5f6f7),
                  //   ),
                  // ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 10.0, left: 12.0),
              sliver: SliverToBoxAdapter(
                  child: Text(
                "Official Merchandise",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 130.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 180.0,
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: NetworkImage(
                                  "https://image.freepik.com/free-vector/ancient-woman-kid-painting-stone-wall-isolated-flat-vector-illustration-cartoon-prehistoric-people-drawing-primitive-animals-hunters-rock-art-design-family-concept_74855-13012.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 0.0),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                  child: Container(
                    color: Color(0xFFf5f6f7),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 10.0, left: 12.0),
              sliver: SliverToBoxAdapter(
                  child: Text(
                "Top Selling",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
            ),
            // SliverList(
            //   delegate: SliverChildListDelegate(
            //     List.generate(4, (idx) {
            //       return Container(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Card(
            //             child: ListTile(
            //               leading: Icon(null),
            //               title: Text("rohit"),
            //               onTap: null,
            //             ),
            //           ),
            //         ),
            //       );
            //     }),
            //   ),
            // ),
          ];
        },
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: GridView.count(
                childAspectRatio: 0.59,
                crossAxisCount: 2,
                children: List.generate(4, (index) {
                  return Card(
                    child: GridTile(
                        footer: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hii there",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            image: NetworkImage(
                                "https://image.freepik.com/free-vector/disco-party-people-dancing-club-having-fun-nightclub-nightlife-discoteque-clubbing-female-dj-cartoon-character-music-concert-vector-isolated-concept-metaphor-illustration_335657-1286.jpg"),
                            fit: BoxFit.cover,
                          ),
                        )),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
