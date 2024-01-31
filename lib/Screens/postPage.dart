import 'dart:convert';

import 'package:demo/components/postCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<dynamic> posts = [];
  getPosts() {
    http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
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
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(
            postId: posts[index]['id'],
            title: posts[index]['title'],
            userId: posts[index]['userId'],
            body: posts[index]['body']);
      },
    );
  }
}
