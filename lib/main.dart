import 'dart:io';
import 'dart:ui' as ui;

import 'package:construct_diet/common/clear_behavior.dart';
import 'package:construct_diet/common/custom_appbar.dart' as custom;
import 'package:construct_diet/common/custom_tab.dart';
import 'package:construct_diet/common/diets_list.dart';
import 'package:construct_diet/storage/local_settings.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/page_transition.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:construct_diet/screens/edit_page.dart';
import 'package:construct_diet/tabs/favorite_tab.dart';
import 'package:construct_diet/tabs/more_tab.dart';
import 'package:construct_diet/tabs/result_tab.dart';
import 'package:construct_diet/theme.dart' as custom;
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/content.dart' as utils;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var model = DataModel();

  final prefs = await SharedPreferences.getInstance();
  var lang = prefs.getString('language');
  if (lang == null) {
    String langCode = ui.window.locale.languageCode;
    lang = Vocabluary.checkLanguage(langCode != null ? langCode : "English");
    prefs.setString('language', lang);
  }

  Vocabluary.setLanguage(lang);
  model.dietList = Diets.load();
  if (model.isSet) model.generateDietWidgetList();

  runApp(MyApp(model: model));
}

Future setTheme(BuildContext c) async {
  var settings = new LocalSettings();
  await settings.getContainer("settings");

  if (settings.isVirtual) {
    settings.setItem("is_dark", false);
    await settings.saveContainer();
  } else {
    bool dark = settings.getItem("is_dark") as bool;

    if (dark) {
      changeTheme(true, c);
    }
  }
}

void changeTheme(bool isNight, BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    DynamicTheme.of(context)
        .setThemeData(isNight ? custom.ThemeIOS.dark : custom.ThemeIOS.light);
  } else {
    DynamicTheme.of(context).setThemeData(
        isNight ? custom.ThemeAndroid.dark : custom.ThemeAndroid.light);
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarBrightness: !isNight ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.white.withAlpha(0),
        statusBarIconBrightness: !isNight ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: !isNight ? Colors.white : Color(0xFF2E2F32),
        systemNavigationBarIconBrightness:
            !isNight ? Brightness.dark : Brightness.light),
  );
}

class MyApp extends StatelessWidget {
  final DataModel model;
  MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setTheme(context);

    return ScopedModel<DataModel>(
      model: model,
      child: DynamicTheme(
          defaultBrightness: Brightness.light,
          data: (brightness) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                  statusBarColor: Colors.white.withAlpha(0),
                  statusBarIconBrightness: brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light,
                  systemNavigationBarColor: brightness == Brightness.light
                      ? Colors.white.withAlpha(150)
                      : Color(0xFF2E2F32).withAlpha(150),
                  systemNavigationBarIconBrightness:
                      brightness == Brightness.light
                          ? Brightness.dark
                          : Brightness.light),
            );
            if (Platform.isIOS) {
              return brightness == Brightness.light
                  ? custom.ThemeIOS.light
                  : custom.ThemeIOS.dark;
            } else {
              return brightness == Brightness.light
                  ? custom.ThemeAndroid.light
                  : custom.ThemeAndroid.dark;
            }
          },
          themedWidgetBuilder: (context, theme) {
            return MaterialApp(
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: ClearBehavior(),
                  child: child,
                );
              },
              debugShowCheckedModeBanner: false,
              title: 'Construct Diet',
              theme: theme,
              home: MainPage(),
            );
          }),
    );
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
  double appBarHeight = 130;
  bool isAnimateScroll = false;
  bool waitAnimation = false;

  final List<Widget> tabs = <Widget>[
    ResultTab(),
    FavoritesTab(),
    MoreTab(),
  ];

  List<String> diagnosisList = <String>[
    Vocabluary.getWord('Weight deficit'),
    Vocabluary.getWord('Underweight'),
    Vocabluary.getWord('Normal weight'),
    Vocabluary.getWord('Overweight'),
    Vocabluary.getWord('Class I obesity'),
    Vocabluary.getWord('Class II obesity'),
    Vocabluary.getWord('Class III obesity')
  ];

  @override
  void initState() {
    super.initState();
    controllerTab = TabController(length: 3, vsync: this);
    controllerScroll = ScrollController();

    ScopedModel.of<DataModel>(context).loadToStorage();
  }

  @override
  void dispose() {
    controllerTab.dispose();
    super.dispose();
  }

  animateScrollInfoContainer(ScrollMetrics metrics) {
    if (step != 0 && step != 1 && !isAnimateScroll) {
      isAnimateScroll = true;
      Future.delayed(Duration(milliseconds: 0), () {}).then((s) {
        controllerScroll
            .animateTo(step < 0.8 ? 56 : 0,
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300))
            .then((s) {
          isAnimateScroll = false;
        });
      });
    }
  }

  Widget appBar() {
    double padding = MediaQuery.of(context).size.width > 700
        ? MediaQuery.of(context).size.width - 779
        : 12;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          padding + (step * 5), 16, padding + (step * 5), 6),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 450),
        height: step > 0.8 ? appBarHeight : 50,
        curve: Curves.fastOutSlowIn,
        child: Hero(
          tag: 'appbar',
          child: Material(
            elevation: 3.5 - (step * 2),
            shadowColor: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.all(Radius.circular(8.5)),
            color: Theme.of(context).cardColor,
            child: InkWell(
              highlightColor: Colors.grey.withAlpha(30),
              splashColor: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.all(Radius.circular(8.5)),
              onTap: () {
                if (step > 0.8)
                  Navigator.push(
                    context,
                    TransitionPageRoute(widget: EditPage()),
                  );
                else if (!isAnimateScroll) {
                  setState(() {
                    waitAnimation = true;
                  });
                  isAnimateScroll = true;
                  controllerScroll
                      .animateTo(0,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(milliseconds: 300))
                      .then((_) {
                    setState(() {
                      waitAnimation = false;
                    });
                    isAnimateScroll = false;
                  });
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(18, 4.5, 18, 4.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Construct Diet",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Icon(
                              step > 0.8 ? MdiIcons.pencil : MdiIcons.arrowUp,
                              size: step > 0.8 ? 18 : 21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedOpacity(
                          duration: step > 0.99
                              ? Duration(milliseconds: 400)
                              : Duration(milliseconds: 0),
                          opacity: step > 0.99 ? 1 : 0,
                          curve: Interval(0.5, 1),
                          child: Container(
                            height: 70,
                            child: ScopedModelDescendant<DataModel>(
                                builder: (context, child, model) {
                              return !model.isSet
                                  ? InfoLabel(
                                      Vocabluary.getWord(
                                          'Specify your parameters'),
                                      description:
                                          Vocabluary.getWord('Click to edit'),
                                      icon: MdiIcons.creation)
                                  : InfoLabel(
                                      diagnosisList[model.getStatus()],
                                      description:
                                          Vocabluary.getWord('Click to edit'),
                                      icon: model.getStatus() == 2
                                          ? MdiIcons.checkCircle
                                          : MdiIcons.alertCircle,
                                      color: model.getStatus() == 2
                                          ? Theme.of(context).primaryColorLight
                                          : Theme.of(context).backgroundColor,
                                    );
                            }),
                          ),
                        ),
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
        body: IgnorePointer(
          ignoring: waitAnimation,
          child: Stack(
            children: <Widget>[
              Center(
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
                                step = ((constraints.maxHeight - 73) *
                                        100 /
                                        (appBarHeight - 73)) /
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
        ),
        bottomNavigationBar: Container(
          child: Center(
            heightFactor: 1,
            child: Container(
              height: (utils.isX(context) && Platform.isIOS) ? 90 : 61,
              alignment: Alignment.center,
              constraints: MediaQuery.of(context).size.width > 780
                  ? BoxConstraints(
                      maxWidth: Theme.of(context).platform == TargetPlatform.iOS
                          ? double.infinity
                          : 765)
                  : BoxConstraints(),
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                border: Theme.of(context).platform == TargetPlatform.iOS
                    ? Border.all(
                        width: 0.5, color: Theme.of(context).dividerColor)
                    : Border(),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.transparent
                        : Colors.black.withAlpha(50),
                    offset: Offset(0, 0),
                    blurRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                    top: Theme.of(context).platform == TargetPlatform.iOS
                        ? Radius.zero
                        : Radius.circular(16)),
              ),
              child: Material(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.vertical(
                    top: Theme.of(context).platform == TargetPlatform.iOS
                        ? Radius.zero
                        : Radius.circular(16)),
                type: MaterialType.transparency,
                child: ConstrainedBox(
                  constraints: MediaQuery.of(context).size.width > 780
                      ? BoxConstraints(
                          maxWidth:
                              Theme.of(context).platform != TargetPlatform.iOS
                                  ? double.infinity
                                  : 765)
                      : BoxConstraints(),
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        labelPadding: EdgeInsets.all(6),
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor:
                            Theme.of(context).primaryColorDark,
                        indicator: MD2Indicator(
                          indicatorHeight: 0,
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorSize: MD2IndicatorSize.full,
                        ),
                        tabs: <Tab>[
                          Tab(
                            child: TabContent(Vocabluary.getWord('Result'),
                                MdiIcons.fileDocumentBoxOutline),
                          ),
                          Tab(
                            child: TabContent(Vocabluary.getWord('Preferences'),
                                MdiIcons.heartOutline),
                          ),
                          Tab(
                              child: TabContent(Vocabluary.getWord('Other'),
                                  MdiIcons.cardBulletedOutline)),
                        ],
                        controller: controllerTab,
                      ),
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Divider(height: 0)
                          : Divider(height: 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
