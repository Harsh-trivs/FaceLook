import 'dart:convert';

import 'package:demo/components/postCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  PostPage({super.key, this.id});
  int? id;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<dynamic>? posts;
  getPosts() {
    http
        .get(Uri.parse(
            "https://jsonplaceholder.typicode.com/posts${widget.id != null ? "?userId=${widget.id}" : ""}"))
        .then((value) => jsonDecode(value.body))
        .then((value) => setState(() {
              posts = value;
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return posts != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: posts!.length,
            itemBuilder: (context, index) {
              return PostCard(
                  postId: posts![index]['id'],
                  title: posts![index]['title'],
                  userId: posts![index]['userId'],
                  body: posts![index]['body']);
            },
          )
        : Center(child: CircularProgressIndicator());
  }
}
