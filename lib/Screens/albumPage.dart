import 'dart:convert';

import 'package:demo/components/albumCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<dynamic> albumList = [];
  getAlbumData() {
    http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"))
        .then((value) => jsonDecode(value.body))
        .then((value) => setState(() {
              albumList = value;
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlbumData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: albumList.length,
      itemBuilder: (context, index) {
        return AlbumCard(
            userId: albumList[index]['userId'],
            id: albumList[index]['id'],
            title: albumList[index]['title']);
      },
    );
  }
}
