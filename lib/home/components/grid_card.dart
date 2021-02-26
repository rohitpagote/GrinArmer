import 'package:flutter/material.dart';

class GridCardComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  }
}
