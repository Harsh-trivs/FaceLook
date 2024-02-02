import 'dart:convert';

import 'package:demo/Screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PeopleCard extends StatefulWidget {
  const PeopleCard({
    Key? key,
    required this.userId,
    required this.name,
    required this.email,
    required this.companyName,
    required this.catchPhrase,
  }) : super(key: key);

  final int userId;
  final String name;
  final String companyName;
  final String email;
  final String catchPhrase;

  @override
  _PeopleCardState createState() => _PeopleCardState();
}

class _PeopleCardState extends State<PeopleCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfilePage(userId: widget.userId)));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 7,
              spreadRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    const CircleAvatar(
                      // You can use a user's profile picture here
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "working in ${widget.companyName}",
                        ),
                        Text(widget.catchPhrase),
                        Text(
                          "connect at: ${widget.email}",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
