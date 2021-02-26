import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

const String randomPersonURL = "https://randomuser.me/api/";

class PersonNetworkService {
  Future<List<Person>> fetchPersons(int amount) async {
    http.Response response = await http.get("$randomPersonURL?results=$amount");

    if (response.statusCode == 200) {
      Map peopleData = jsonDecode(response.body);
      List<dynamic> peoples = peopleData["results"];
      return peoples.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }
}

class Person {
  String name;
  String phoneNumber;
  String imageUrl;

  Person({this.name, this.phoneNumber, this.imageUrl});

  Person.fromJson(Map<String, dynamic> json)
      : name =
            "${json["name"]["title"]} ${json["name"]["first"]} ${json["name"]["last"]}",
        phoneNumber = json["phone"],
        imageUrl = json["picture"]["thumbnail"];
}

class HomeScreen extends StatelessWidget {
  final PersonNetworkService personService = PersonNetworkService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: FutureBuilder(
            future: personService.fetchPersons(100),
            builder:
                (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Card(
                          // color: Colors.black.withOpacity(0.5),
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var currentPerson = snapshot.data[index];
                                return ListTile(
                                  title: Text(currentPerson.name),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(currentPerson.imageUrl),
                                  ),
                                  subtitle: Text(
                                      "Phone: ${currentPerson.phoneNumber}"),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                return Center(
                    child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 82.0,
                ));
              }

              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Loading at the moment, please hold the line.")
                ],
              ));
            },
          ),
        ),
      ),
    );
  }
}
