import 'package:flutter/material.dart';
import 'ui/common/custom_app_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Construct Diet',
      theme: ThemeData(
          primaryTextTheme: TextTheme(body1: TextStyle(color: Colors.white))),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[CustomAppBar()],
      ),
    );
  }
}
