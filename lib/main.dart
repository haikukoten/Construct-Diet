import 'package:construct_diet/common/custom_tab.dart';
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/page_transition.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:construct_diet/screens/edit_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import 'common/custom_appbar.dart' as custom;
import 'theme.dart' as custom;
import 'tabs/favorite_tab.dart';
import 'tabs/result_tab.dart';
import 'tabs/more_tab.dart';

void main() => runApp(MyApp(model: DataModel()));

class MyApp extends StatelessWidget {
  final DataModel model;
  MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white.withAlpha(0),
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
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

  final List<Widget> tabs = <Widget>[
    ResultTab(),
    FavoritesTab(),
    MoreTab(),
  ];

  List<String> diagnosisList = <String>[
    'Выраженный недостаток веса',
    'Недостаточный вес',
    'Нормальный вес',
    'Избыточный вес',
    'Первая степень ожирения',
    'Вторая степень ожирения',
    'Третья степень ожирения'
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
    return Padding(
      padding: EdgeInsets.fromLTRB(12 + (step * 5), 16, 12 + (step * 5), 6),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 450),
        height: step > 0.8 ? appBarHeight : 50,
        curve: Curves.fastOutSlowIn,
        child: Hero(
          tag: 'appbar',
          child: Material(
            elevation: 3.5 - (step * 2),
            shadowColor: Theme.of(context).dividerColor,
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
                  isAnimateScroll = true;
                  controllerScroll
                      .animateTo(0,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(milliseconds: 300))
                      .then((s) {
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.caption.color,
                            ),
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
                      padding: EdgeInsets.only(top: 33),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedOpacity(
                          duration: step > 0.99
                              ? Duration(milliseconds: 400)
                              : Duration(milliseconds: 0),
                          opacity: step > 0.99 ? 1 : 0,
                          curve: Interval(0.5, 1),
                          child: Container(
                            height: 65,
                            child: ScopedModelDescendant<DataModel>(
                                builder: (context, child, model) {
                              return !model.isSet
                                  ? InfoLabel("Укажите свои параметры",
                                      description: "Нажмите для редактирования",
                                      icon: MdiIcons.creation)
                                  : InfoLabel(
                                      diagnosisList[model.getStatus()],
                                      description: "Нажмите для редактирования",
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
      body: Stack(
        children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: MediaQuery.of(context).size.width > 700
                  ? BoxConstraints(maxWidth: 750)
                  : BoxConstraints(),
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
          ),
        ],
      ),
      bottomNavigationBar: Center(
        heightFactor: 1,
        child: Container(
          height: 61,
          alignment: Alignment.center,
          constraints: MediaQuery.of(context).size.width > 780
              ? BoxConstraints(maxWidth: 765)
              : BoxConstraints(),
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
      ),
    );
  }
}
