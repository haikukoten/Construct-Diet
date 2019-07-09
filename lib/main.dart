import 'ui/tabs/result_tab.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'ui/common/rounded_app_bar.dart';
import 'ui/tabs/favorite_tab.dart';
import 'ui/tabs/settings_tab.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.black.withAlpha(2),
          systemNavigationBarColor: Colors.black.withAlpha(5),
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
                statusBarIconBrightness: brightness,
                systemNavigationBarColor: brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey[850],
                systemNavigationBarIconBrightness:
                    brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light),
          );
          return ThemeData(
            brightness: brightness,
            primaryColor: brightness == Brightness.light
                ? Colors.pink[300]
                : Colors.teal[300],
            bottomAppBarColor: brightness == Brightness.light
                ? Colors.white
                : Colors.grey[850],
            scaffoldBackgroundColor: brightness == Brightness.light
                ? Colors.grey[50]
                : Colors.grey[900],
            primaryTextTheme: TextTheme(
              body1: TextStyle(color: Colors.white),
            ),
          );
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

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<Widget> tabs = <Widget>[
    ResultTab(),
    FavoritesTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: tabs,
            controller: controller,
          ),
          RoundedAppBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 57,
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 4,
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Material(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                type: MaterialType.transparency,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      labelPadding: EdgeInsets.all(4),
                      labelColor: Theme.of(context).primaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.grey[600],
                      indicator: MD2Indicator(
                          indicatorHeight: 3,
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorSize: MD2IndicatorSize.full),
                      tabs: <Tab>[
                        Tab(
                          icon: Icon(MdiIcons.fileDocumentBoxOutline),
                        ),
                        Tab(
                          icon: Icon(Icons.favorite_border),
                        ),
                        Tab(
                          icon: Icon(MdiIcons.settingsOutline),
                        ),
                      ],
                      controller: controller,
                    ),
                    Divider(height: 1)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
