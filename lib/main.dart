import 'package:flutter/rendering.dart';

import 'ui/tabs/result_tab.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'ui/tabs/favorite_tab.dart';
import 'ui/tabs/settings_tab.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'ui/common/custom_appbar.dart' as custom;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white.withAlpha(0),
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
                statusBarColor: Colors.white.withAlpha(0),
                statusBarIconBrightness: brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light,
                systemNavigationBarColor: brightness == Brightness.light
                    ? Colors.white
                    : Color(0xFF2E2F32),
                systemNavigationBarIconBrightness:
                    brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light),
          );
          return ThemeData(
            brightness: brightness,
            primaryColor: brightness == Brightness.light
                ? Color(0xFF1A73E8)
                : Color(0xFF185ABC),
            cardColor: brightness == Brightness.light
                ? Color(0xFFFFFFFF)
                : Color(0xFF2E2F32),
            bottomAppBarColor: brightness == Brightness.light
                ? Colors.white
                : Color(0xFF2E2F32),
            scaffoldBackgroundColor: brightness == Brightness.light
                ? Colors.white
                : Color(0xFF202124),
            cardTheme: CardTheme(
              color: brightness == Brightness.light
                  ? Color(0xFFEEEEEE)
                  : Color(0xFF1D1E21),
            ),
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
  TabController controllerTab;

  @override
  void initState() {
    super.initState();
    controllerTab = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controllerTab.dispose();
    super.dispose();
  }

  final List<Widget> tabs = <Widget>[
    ResultTab(),
    FavoritesTab(),
    SettingsTab(),
  ];

  Widget infoContainer(double step) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Container(
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).cardTheme.color),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18, 6, 18, 6),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(step.toString(),
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(step.toString(),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double appBarHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  custom.SliverAppBar(
                    pinned: true,
                    expandedHeight: appBarHeight,
                    floating: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        double step = ((constraints.maxHeight - 84.0) *
                            100 /
                            (appBarHeight - 84.0));
                        return infoContainer(step);
                      },
                    ),
                  ),
                ];
              },
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: tabs,
                controller: controllerTab,
              ),
            ),
          ),
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
                      controller: controllerTab,
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
