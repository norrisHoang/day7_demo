import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: ScreenNotification(),
    );
  }
}
class ScreenNotification extends StatefulWidget{
  @override
  _NotificationPageState createState() => _NotificationPageState();
}
class _NotificationPageState extends State<ScreenNotification>{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Nitification'),
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}