import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentCard extends StatefulWidget {
  const CommentCard({
    super.key,
    required this.name,
    required this.email,
    required this.body,
  });
  final String name;
  final String email;
  final String body;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        width: double.maxFinite,
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
                      widget.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
            //body
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  widget.body,
                  style: TextStyle(fontSize: 16),
                ),
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
                      "created by : ${widget.email}",
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
