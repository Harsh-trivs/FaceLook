import 'dart:convert';

import 'package:demo/components/commentCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.postId});
  final int postId;
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<dynamic> commentList = [];
  getComment() {
    http
        .get(Uri.parse(
            "https://jsonplaceholder.typicode.com/comments?postId=${widget.postId}"))
        .then((value) => jsonDecode(value.body))
        .then((value) => setState(() {
              commentList = value;
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: commentList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 350,
            child: CommentCard(
                name: commentList[index]["name"],
                email: commentList[index]["email"],
                body: commentList[index]["body"]),
          );
        },
      ),
    );
  }
}
