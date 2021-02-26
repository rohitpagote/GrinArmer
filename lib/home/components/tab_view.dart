import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:distributer_application/base/color_properties.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String url = "https://reqres.in/api/users?page=2";

class FeaturedService {
  Future<List<Featured>> fetchFeatured() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map featuredData = jsonDecode(response.body);
      List<dynamic> featured = featuredData["data"];
      return featured.map((json) => Featured.fromJson(json)).toList();
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }
}

class Featured {
  int featuredId;
  String featuredUrl;
  String first_name, last_name;

  Featured(
      {this.featuredId, this.featuredUrl, this.first_name, this.last_name});

  Featured.fromJson(Map<String, dynamic> json)
      : featuredId = json["id"],
        featuredUrl = json["avatar"],
        first_name = json["first_name"],
        last_name = json["last_name"];
}

class FeaturedComponent extends StatelessWidget {
  final FeaturedService bannerService = FeaturedService();

  final style = TextStyle(
    color: white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bannerService.fetchFeatured(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: InkWell(
                onTap: () {
                  print('$index');
                  // // use this line if you want to pass index position on the next page
                  // Navigator.of(context).pushNamed('YOUR_PAGE', arguments: '$index');
                  // //or if you don't want to pass anything use this
                  // Navigator.of(context).pushNamed('YOUR_PAGE');
                },
                child: Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data[index].featuredUrl),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              snapshot.data[index].first_name,
                              style: style,
                            ),
                            Text(
                              snapshot.data[index].last_name,
                              style: style,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
            },
            itemCount: snapshot.data.length,
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
                builder: DotSwiperPaginationBuilder(
                    color: Colors.grey[400],
                    size: 6.0,
                    activeColor: Colors.black,
                    activeSize: 8.0)),
            // control: SwiperControl(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
