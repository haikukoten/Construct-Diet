import 'package:construct_diet/ui/common/custom_tab.dart';
import 'package:construct_diet/ui/common/labels.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import 'ui/common/custom_appbar.dart' as custom;
import 'ui/common/theme.dart' as custom;
import 'ui/tabs/favorite_tab.dart';
import 'ui/tabs/result_tab.dart';
import 'ui/tabs/more_tab.dart';

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
          return brightness == Brightness.light
              ? custom.Theme.light
              : custom.Theme.dark;
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
  double step;
  double appBarHeight = 122;
  bool isAnimateScroll = false;

  final List<Widget> tabs = <Widget>[
    ResultTab(),
    FavoritesTab(),
    MoreTab(),
  ];

  @override
  void initState() {
    super.initState();
    controllerTab = TabController(length: 3, vsync: this);
    controllerScroll = ScrollController();
  }

  @override
  void dispose() {
    controllerTab.dispose();
    super.dispose();
  }

  animateScrollInfoContainer(ScrollMetrics metrics) {
    if (step != 0 && step != 1 && !isAnimateScroll) {
      isAnimateScroll = true;
      Future.delayed(const Duration(milliseconds: 0), () {}).then((s) {
        controllerScroll
            .animateTo(step < 0.7 ? 57 : -appBarHeight,
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300))
            .then((s) {
          isAnimateScroll = false;
        });
      });
    }
  }

  Widget separatorVertical() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Container(
        width: 1,
        height: 25,
        color: Theme.of(context).primaryColorDark.withAlpha(50),
      ),
    );
  }

  Widget infoBlock(String title, int value) {
    return Column(
      children: <Widget>[
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.caption.color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).textTheme.caption.color.withAlpha(200),
            ),
          ),
        )
      ],
    );
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: step > 0.6 ? appBarHeight : 50,
        curve: Curves.fastOutSlowIn,
        child: Hero(
          tag: 'appbar',
          child: Material(
            elevation: step > 0 ? 2 : 3,
            shadowColor: Colors.black.withAlpha(150),
            borderRadius: BorderRadius.all(Radius.circular(8.5)),
            color: Theme.of(context).cardColor,
            child: InkWell(
              highlightColor: Colors.grey.withAlpha(30),
              splashColor: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.all(Radius.circular(8.5)),
              onTap: () {
                );
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 4.5, 7, 4.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Construct Diet",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.caption.color,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Icon(
                              MdiIcons.pencil,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedOpacity(
                        duration: step > 0.8
                            ? Duration(milliseconds: 400)
                            : Duration(milliseconds: 0),
                        opacity: step > 0.8 ? 1 : 0,
                        curve: Interval(0.5, 1),
                        child: Container(
                            height: 56,
                            child: InfoLabel('Избыточный вес',
                                description: 'Необходимо сбросить 12 кг.',
                                icon: MdiIcons.alertCircle,
                                color: Colors.orange)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                          step = ((constraints.maxHeight - 65) *
                                  100 /
                                  (appBarHeight - 65)) /
                              100;
                          return appBar();
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
        ],
      ),
      bottomNavigationBar: Container(
        height: 61,
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
                labelPadding: EdgeInsets.all(6),
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).primaryColorDark,
                indicator: MD2Indicator(
                  indicatorHeight: 0,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorSize: MD2IndicatorSize.full,
                ),
                tabs: <Tab>[
                  Tab(
                    child: TabContent(
                        "Результат", MdiIcons.fileDocumentBoxOutline),
                  ),
                  Tab(
                    child: TabContent("Предпочтения", MdiIcons.heartOutline),
                  ),
                  Tab(
                      child:
                          TabContent("Другое", MdiIcons.cardBulletedOutline)),
                ],
                controller: controllerTab,
              ),
              Divider(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
