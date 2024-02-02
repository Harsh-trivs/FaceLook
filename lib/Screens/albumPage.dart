import 'dart:convert';

import 'package:demo/components/albumCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumPage extends StatefulWidget {
  AlbumPage({super.key, this.id});
  int? id;
  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<dynamic>? albumList;
  getAlbumData() {
    http
        .get(Uri.parse(
            "https://jsonplaceholder.typicode.com/albums${widget.id != null ? "?userId=${widget.id}" : ""}"))
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
    return albumList != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: albumList!.length,
            itemBuilder: (context, index) {
              return AlbumCard(
                  userId: albumList![index]['userId'],
                  id: albumList![index]['id'],
                  title: albumList![index]['title']);
            },
          )
        : Center(child: CircularProgressIndicator());
  }
}
