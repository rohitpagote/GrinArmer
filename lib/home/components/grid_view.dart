import 'package:distributer_application/base/color_properties.dart';
import 'package:flutter/material.dart';

class GridViewComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      physics: BouncingScrollPhysics(),
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 1,
      //   childAspectRatio: 1.75,
      // ),
      itemBuilder: (BuildContext context, int index) {
        // return Card(
        //   child: GridTile(
        //       footer: Center(
        //           child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text(
        //           "Hii there",
        //           style: TextStyle(fontWeight: FontWeight.bold),
        //         ),
        //       )),
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(8.0),
        //         child: Image(
        //           image: NetworkImage(
        //               "https://image.freepik.com/free-vector/disco-party-people-dancing-club-having-fun-nightclub-nightlife-discoteque-clubbing-female-dj-cartoon-character-music-concert-vector-isolated-concept-metaphor-illustration_335657-1286.jpg"),
        //           fit: BoxFit.cover,
        //         ),
        //       )),
        // );
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width / 2) -
                25, // put 190 for landscape
            child: InkWell(
              onTap: () {
                print("tapped {$index}");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 190.0,
                    color: Colors.red,
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
                      padding: const EdgeInsets.only(
                          bottom: 8.0, right: 8.0, left: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "Category Name",
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
            ),
          ),
        );
      },
    );
  }
}
