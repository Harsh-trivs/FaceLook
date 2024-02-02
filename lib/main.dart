import 'package:demo/Screens/albumPage.dart';
import 'package:demo/Screens/connectPage.dart';
import 'package:demo/Screens/postPage.dart';
import 'package:demo/Screens/profilePage.dart';
import 'package:demo/components/albumCard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  List<Widget> pageList = [AlbumPage(), PostPage(), ConnectPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (val) => setState(() {
                index = val;
              }),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              label: "Album",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded), label: "Posts"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          ]),
      body: pageList[index],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "FaceLook",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(userId: 1))),
              child: CircleAvatar(
                // You can use a user's profile picture here
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
