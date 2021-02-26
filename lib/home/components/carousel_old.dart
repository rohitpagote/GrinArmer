import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url = "https://reqres.in/api/users?page=2";

final bannerImg = [];

// NetworkImage(snapshot.data[0].bannerUrl),
// NetworkImage(snapshot.data[1].bannerUrl),
// NetworkImage(snapshot.data[2].bannerUrl),
// snapshot.data.forEach((banner, index) => {
//       print(banner.bannerUrl),
//     })

class BannerService {
  Future<List<Banner>> fetchBanners() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map bannerData = jsonDecode(response.body);
      List<dynamic> banners = bannerData["data"];
      return banners.map((json) => Banner.fromJson(json)).toList();
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }
}

class Banner {
  int bannerId;
  String bannerUrl;

  Banner({this.bannerId, this.bannerUrl});

  Banner.fromJson(Map<String, dynamic> json)
      : bannerId = json["id"],
        bannerUrl = json["avatar"];
}

class CarouselComponentDemo extends StatelessWidget {
  final BannerService bannerService = BannerService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: bannerService.fetchBanners(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data[0].bannerUrl);
            print(snapshot.data);
            return Carousel(
              boxFit: BoxFit.cover,
              autoplay: true,
              autoplayDuration: Duration(milliseconds: 5000),
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 6.0,
              // dotIncreasedColor: Color(0xFFFF335C),
              dotBgColor: Colors.transparent,
              dotPosition: DotPosition.bottomCenter,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 7.0,
              images: bannerImg,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
