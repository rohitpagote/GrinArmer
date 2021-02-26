import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

const String url = "https://betasources.in/projects/grin-armer/get-all-banners";
// https://reqres.in/api/users?page=2

class CarouselComponent extends StatelessWidget {
  Future<List<dynamic>> fetchBanners() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error, ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchBanners(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data[0]["image"]);
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return CachedNetworkImage(
                  imageUrl: snapshot.data[index]["image"],
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              },
              autoplay: true,
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              pagination: SwiperPagination(alignment: Alignment.bottomCenter),
              // control: SwiperControl(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
