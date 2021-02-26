import 'package:distributer_application/base/color_properties.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: EasyLoader(
          image: AssetImage('assets/GrinArmerLogo.png'),
          backgroundColor: white,
          iconColor: Colors.green,
          iconSize: 60.0,
        ),
      ),
    );
  }
}
