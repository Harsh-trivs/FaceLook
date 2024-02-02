import 'dart:convert';

import 'package:demo/Screens/albumPage.dart';
import 'package:demo/Screens/postPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userId});
  final int userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic user;
  getUser() {
    http
        .get(Uri.parse(
            "https://jsonplaceholder.typicode.com/users/${widget.userId}"))
        .then((value) => jsonDecode(value.body))
        .then((value) => setState(() {
              user = value;
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [
      PostPage(
        id: widget.userId,
      ),
      AlbumPage(
        id: widget.userId,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user?['username'] ?? '',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: user != null
          ? ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        // You can use a user's profile picture here
                        radius: 35,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['name'],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "working in ${user['company']['name']}",
                          ),
                          Text(user['company']['catchPhrase']),
                          Text(
                            "connect at: ${user['email']}",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0,
                    ),
                    InkWell(
                      onTap: () => {
                        setState(() {
                          index = 0;
                        })
                      },
                      child: Container(
                        decoration: index == 0
                            ? BoxDecoration(
                                border: Border(
                                bottom: BorderSide(
                                    color: Colors.purpleAccent.shade200,
                                    width: 3),
                              ))
                            : BoxDecoration(),
                        child: Text(
                          "Posts",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        setState(() {
                          index = 1;
                        })
                      },
                      child: Container(
                        decoration: index == 1
                            ? BoxDecoration(
                                border: Border(
                                bottom: BorderSide(
                                    color: Colors.purpleAccent.shade200,
                                    width: 3),
                              ))
                            : BoxDecoration(),
                        child: Text(
                          "Albums",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    SizedBox(width: 0),
                  ],
                ),
                pageList[index],
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
