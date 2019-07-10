import 'dart:math';

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
  ScrollController controllerScroll;
  double step = 100;
  double appBarHeight = 150;
  bool isAnimateScroll = false;

  @override
  void initState() {
    super.initState();
    controllerTab = new TabController(length: 3, vsync: this);
    controllerScroll = ScrollController();
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

  _onEndScroll(ScrollMetrics metrics) {
    if (metrics.pixels != 0 && metrics.pixels < 68 && !isAnimateScroll) {
      isAnimateScroll = true;
      Future.delayed(const Duration(milliseconds: 0), () {}).then((s) {
        controllerScroll
            .animateTo(step < 50 ? 68 : -appBarHeight,
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 200))
            .then((s) {
          isAnimateScroll = false;
        });
      });
    }
  }

  Widget infoContainer(double step) {
    final contentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 14, 18, 14),
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).cardTheme.color),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: contentWidth - 70,
                      child: Text(
                        "Construct Diet",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  _onEndScroll(scrollNotification.metrics);
                }
              },
              child: NestedScrollView(
                controller: controllerScroll,
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
                          step = ((constraints.maxHeight - 82) *
                              100 /
                              (appBarHeight - 82));
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
                    blurRadius: 3,
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
