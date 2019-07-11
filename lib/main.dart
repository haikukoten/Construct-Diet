import 'package:construct_diet/ui/common/custom_tab.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import 'ui/common/theme.dart' as custom;
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
  AnimationController controllerAnimation;
  Animation<AlignmentGeometry> animationTitle;
  Animation<double> animationOpacity;
  double appBarHeight = 140;
  bool isAnimateScroll = false;

  final List<Widget> tabs = <Widget>[
    ResultTab(),
    FavoritesTab(),
    SettingsTab(),
  ];

  @override
  void initState() {
    super.initState();
    controllerTab = TabController(length: 3, vsync: this);
    controllerScroll = ScrollController();
    controllerAnimation = AnimationController(vsync: this);

    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
        parent: controllerAnimation,
        curve: new Interval(0.5, 1, curve: Curves.easeInOutSine)));

    animationTitle = Tween<AlignmentGeometry>(
            begin: Alignment.centerLeft, end: Alignment.topCenter)
        .animate(CurvedAnimation(
            parent: controllerAnimation, curve: Curves.easeInOutSine));
  }

  @override
  void dispose() {
    controllerTab.dispose();
    super.dispose();
  }

  animateScrollInfoContainer(ScrollMetrics metrics) {
    if (controllerAnimation.value != 0 &&
        controllerAnimation.value != 1 &&
        !isAnimateScroll) {
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.caption.color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.caption.color.withAlpha(200),
            ),
          ),
        )
      ],
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 16),
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
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              AlignTransition(
                alignment: animationTitle,
                child: Text(
                  "Construct Diet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FadeTransition(
                  opacity: animationOpacity,
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        infoBlock("лет", 16),
                        separatorVertical(),
                        infoBlock("кг", 65),
                        separatorVertical(),
                        infoBlock("см", 182),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  MdiIcons.pencil,
                  size: 18,
                ),
              ),
            ],
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
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SafeArea(
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
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            controllerAnimation.value =
                                ((constraints.maxHeight - 82) *
                                        100 /
                                        (appBarHeight - 82)) /
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
                    child:
                        TabContent("Главная", MdiIcons.fileDocumentBoxOutline),
                  ),
                  Tab(
                    child: TabContent("Предпочтения", MdiIcons.heartOutline),
                  ),
                  Tab(
                    child: TabContent("Настройки", MdiIcons.settingsOutline),
                  ),
                ],
                controller: controllerTab,
              ),
              Divider(height: 1)
            ],
          ),
        ),
      ),
    );
  }
}
