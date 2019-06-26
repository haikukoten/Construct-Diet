import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'ui/common/custom_app_bar.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarIconBrightness: brightness,
              systemNavigationBarDividerColor: Colors.white,
              systemNavigationBarColor: brightness == Brightness.light
                  ? Colors.grey[50]
                  : Colors.grey[850],
              systemNavigationBarIconBrightness: brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light));
          return ThemeData(
              brightness: brightness,
              /*--Gradient Start--*/
              accentColor: Color(0xffF55B9A),
              primaryColor: Color(0xffF9B16E),
              /*--Gradient End--*/
              primaryTextTheme:
                  TextTheme(body1: TextStyle(color: Colors.white)));
        },
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Construct Diet',
            theme: theme,
            home: MainPage(),
          );
        });
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
