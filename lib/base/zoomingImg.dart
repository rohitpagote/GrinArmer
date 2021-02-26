import 'package:distributer_application/base/color_properties.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomingImg extends StatelessWidget {
  final String img;

  ZoomingImg({Key key, @required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: appColor,
        ),
      ),
      body: GestureDetector(
          child: PhotoView(
            imageProvider: NetworkImage(img),
            backgroundDecoration: BoxDecoration(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
          }),
    );
  }
}
