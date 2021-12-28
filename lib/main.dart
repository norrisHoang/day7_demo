import 'dart:convert';
import 'dart:ffi';
import 'package:day7_demo2/model/model_movie.dart';
import 'package:day7_demo2/screens/screen_listview.dart';
import 'package:day7_demo2/screens/screen_wrap.dart';
import 'package:day7_demo2/screens/screen_api.dart';
import 'package:day7_demo2/screens/screen_notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Object data;
  List imagesUrl = [];
  double pos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('List Of Images'),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.fromLTRB(160, 40, 0, 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScreenListView()));
            },
            child: Text('List View'),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(160, 40, 0, 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScreenWrap()));
            },
            child: Text('Wrap'),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(160, 40, 0, 20),
          child: ElevatedButton(
            onPressed: () {
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScreenApi()));
              }
            },
            child: Text('Api'),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(160, 40, 0, 0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenNotification()));
            },
            child: Text('Push Notification'),
          ),
        )
      ]),
    );
  }
}
