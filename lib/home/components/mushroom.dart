import 'package:distributer_application/base/color_properties.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class MushroomComponent extends StatelessWidget {
  static const int PAGE_SIZE = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PagewiseGridView.count(
          pageSize: PAGE_SIZE,
          crossAxisCount: 1,
          // mainAxisSpacing: 8.0,
          // crossAxisSpacing: 8.0,
          childAspectRatio: 1.5,
          padding: EdgeInsets.all(15.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: this._itemBuilder,
          pageFuture: (pageIndex) =>
              BackendService.getImages(pageIndex * PAGE_SIZE, PAGE_SIZE),
          loadingBuilder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _itemBuilder(context, ProductModel entry, index) {
    print("category");
    print(entry.category);
    print("Products");
    print(entry.products);
    return Card(
        child: InkWell(
      onTap: () {
        print("tapped {$index}");
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.transparent,
            height: 175.0,
            // width: MediaQuery.of(context).size.width,
            child: GridTile(
                child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
              child:
//              Image.network(
//                entry.img,
//                fit: BoxFit.cover,
//              ),
                  Text("R"),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Divider(
              color: appColor,
              // height: 20,
              thickness: 1,
            ),
          ),
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
              child: Column(
                children: [
                  Text(
                    entry.category,
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
                    "Weight : 10gm",
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
    ));
  }
}

class BackendService {
  static Future<List<ProductModel>> getImages(offset, limit) async {
//    final responseBody = (await http.get(
//            'http://jsonplaceholder.typicode.com/photos?_start=$offset&_limit=$limit'))
//        .body;

    final response = await http
        .get("https://betasources.in/projects/grin-armer/get-all-products");

    final responseBody = response.body;

    // The response body is an array of items.
    return ProductModel.fromJsonList(json.decode(responseBody));
  }
}

class ProductModel {
  String category;
//  String id;
//  String thumbnailUrl;
  String products;
//  String img;

  ProductModel.fromJson(obj) {
    this.category = obj['category'];
//    this.id = obj['id'].toString();
//    this.thumbnailUrl = obj['thumbnailUrl'];
//    this.products = obj["products"];
//    this.img = obj["products"][0]["images"][0];
  }

  static List<ProductModel> fromJsonList(jsonList) {
    return jsonList
        .map<ProductModel>((obj) => ProductModel.fromJson(obj))
        .toList();
  }
}
