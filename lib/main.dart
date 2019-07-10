import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import 'ui/common/custom_appbar.dart' as custom;
import 'ui/tabs/favorite_tab.dart';
import 'ui/tabs/result_tab.dart';
import 'ui/tabs/settings_tab.dart';

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
                : Color(0xFF8AB4F8),
            primaryColorDark: brightness == Brightness.light
                ? Color(0xFF5F6368)
                : Color(0xFF9AA0A6),
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
              caption: TextStyle(
                color: brightness == Brightness.light
                    ? Color(0xFF3C4043)
                    : Color(0xFFFFFFFF),
              ),
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

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TabController controllerTab;
  ScrollController controllerScroll;
  AnimationController controllerAnimation;
  Animation<AlignmentGeometry> animationTitle;
  double appBarHeight = 150;
  bool isAnimateScroll = false;

  final List<Widget> tabs = <Widget>[
    ResultTab(),
    FavoritesTab(),
    SettingsTab(),
  ];

  @override
  void initState() {
    super.initState();
    controllerTab = new TabController(length: 3, vsync: this);
    controllerScroll = ScrollController();
    controllerAnimation = AnimationController(vsync: this);

    animationTitle = Tween<AlignmentGeometry>(
            begin: Alignment.centerLeft, end: Alignment.center)
        .animate(new CurvedAnimation(
            parent: controllerAnimation,
            curve: new Interval(0.0, 1, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    controllerTab.dispose();
    super.dispose();
  }

  animateScrollInfoContainer(ScrollMetrics metrics) {
    if (metrics.pixels != 0 && metrics.pixels < 68 && !isAnimateScroll) {
      isAnimateScroll = true;
      Future.delayed(const Duration(milliseconds: 0), () {}).then((s) {
        controllerScroll
            .animateTo(controllerAnimation.value < 0.5 ? 68 : -appBarHeight,
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300))
            .then((s) {
          isAnimateScroll = false;
        });
      });
    }
  }

  Widget infoContainer() {
    final contentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 14.5, 18, 14.5),
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).cardTheme.color),
          boxShadow: [
            BoxShadow(
              color: controllerAnimation.value == 0.0
                  ? Colors.black.withAlpha(30)
                  : Colors.black.withAlpha(15),
              blurRadius: 2,
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
                      width: contentWidth - 70,
                      child: AlignTransition(
                        alignment: animationTitle,
                        child: Text(
                          "Construct Diet",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .caption
                                .color,
                          ),
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
                  animateScrollInfoContainer(scrollNotification.metrics);
                }
                return true;
              },
              child: NestedScrollView(
                controller: controllerScroll,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    custom.SliverAppBar(
                      pinned: true,
                      expandedHeight: appBarHeight,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      flexibleSpace: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          controllerAnimation.value =
                              ((constraints.maxHeight - 82) *
                                      100 /
                                      (appBarHeight - 82)) /
                                  100;
                          return infoContainer();
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
                      unselectedLabelColor: Theme.of(context).primaryColorDark,
                      indicator: MD2Indicator(
                        indicatorHeight: 3,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorSize: MD2IndicatorSize.full,
                      ),
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
