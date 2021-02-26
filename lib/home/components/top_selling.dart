import 'package:flutter/material.dart';
import 'package:distributer_application/base/color_properties.dart';

class TopSelling extends StatefulWidget {
  @override
  _TopSellingState createState() => _TopSellingState();
}

class _TopSellingState extends State<TopSelling> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mainColor,
                ),
              ),
              Center(
                  child: Text(
                'Recommended',
                style: TextStyle(
                    color: mainColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () => {},
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                           colors: [Colors.grey[500], Colors.grey[700]],
                            center: Alignment(0, 0),
                            radius: 0.6,
//                            focal: Alignment(0, 0),
//                            focalRadius: 0.1),
                      ),
//                      child: Hero(
//                          tag: Text("Ro"),
//                          child: Text("Rohit"),
    )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}