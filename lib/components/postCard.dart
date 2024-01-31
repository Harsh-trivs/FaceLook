import 'dart:convert';

import 'package:demo/Screens/commentPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.title,
    required this.userId,
    required this.body,
    required this.postId,
  });
  final String title;
  final int userId;
  final String body;
  final int postId;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String createdBy = "";
  getCreatedBy() {
    http
        .get(Uri.parse(
            "https://jsonplaceholder.typicode.com/users/${widget.userId}"))
        .then((value) => jsonDecode(value.body))
        .then((value) => setState(() {
              createdBy = value['name'];
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCreatedBy();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
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
          ]),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                //post title
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                widget.body,
                style: TextStyle(fontSize: 16),
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CommentPage(postId: widget.postId)));
                      },
                      icon: Icon(Icons.message)),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "created by : ${createdBy}",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            )

            //
          ],
        ),
      ),
    );
    ;
  }
}
