import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumCard extends StatefulWidget {
  const AlbumCard(
      {super.key, required this.userId, required this.id, required this.title});
  final int userId;
  final int id;
  final String title;

  @override
  State<AlbumCard> createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  String? albumImageUrl;
  String postTitle = "";
  String createdBy = "";
  String placeholderUrl = "";

  getAlbumImageUrl() {
    http
        .get(Uri.parse(
            "https://jsonplaceholder.typicode.com/photos?albumId=${widget.id}"))
        .then((value) => jsonDecode(value.body))
        .then(
          (value) => setState(() {
            albumImageUrl = value[0]["url"];
            placeholderUrl = value[0]['thumbnailUrl'];
          }),
        );
  }

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
    getAlbumImageUrl();
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
            //image and post title
            Row(
              children: [
                //user image
                Container(
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    backgroundImage: NetworkImage(placeholderUrl),
                    radius: 20,
                  ),
                ),
                //post title
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),

            //photo
            albumImageUrl != null
                ? Container(
                    width: 300,
                    height: 300,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(albumImageUrl!)),
                        borderRadius: BorderRadius.circular(20)),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
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
  }
}
