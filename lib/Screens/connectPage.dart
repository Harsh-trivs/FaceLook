import 'dart:convert';

import 'package:demo/components/peopleCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  List<dynamic> users = [];
  getUsers() {
    http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/users"))
        .then((value) => jsonDecode(value.body))
        .then((value) => setState(() {
              users = value;
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return PeopleCard(
            companyName: users[index]['company']['name'],
            userId: users[index]['id'],
            name: users[index]['username'],
            email: users[index]['email'],
            catchPhrase: users[index]['company']['catchPhrase'],
          );
        },
      ),
    );
  }
}
