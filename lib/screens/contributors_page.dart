import 'package:construct_diet/common/avatar.dart';
import 'package:construct_diet/common/buttons.dart' as custom;
import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/screen_body.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class ContributorsPage extends StatefulWidget {
  @override
  _ContributorsPageState createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage>
    with TickerProviderStateMixin {
  TabController controllerTab;

  @override
  void initState() {
    super.initState();
    controllerTab = TabController(length: 2, vsync: this);
    controllerTab.addListener(() {});
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17, 16, 17, 5),
      child: Hero(
        tag: 'appbar',
        child: Material(
          elevation: 1.5,
          shadowColor: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.all(Radius.circular(8.5)),
          color: Theme.of(context).cardColor,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                    child: Row(
                      children: <Widget>[
                        custom.IconButton(
                          icon: Theme.of(context).platform == TargetPlatform.iOS
                              ? Icons.arrow_back_ios
                              : Icons.arrow_back,
                          iconSize:
                              Theme.of(context).platform == TargetPlatform.iOS
                                  ? 18
                                  : 22,
                          onPressed: () => Navigator.pop(context),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            Vocabluary.getWord('Project Contributors'),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: <Widget>[
                        InfoLabel("Вклад в разработку",
                            description: "↑154 ↓50 строк кода в сумме.",
                            icon: MdiIcons.codeTags),
                        InfoLabel("Денежный вклад",
                            description: "\$50.4 в сумме.",
                            icon: MdiIcons.coin),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 2, 25, 0),
                    child: TabBar(
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).primaryColorDark,
                      indicator: MD2Indicator(
                        indicatorHeight: 3,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorSize: MD2IndicatorSize.normal,
                      ),
                      tabs: [
                        Tab(
                          child: Text("Разработчики"),
                        ),
                        Tab(
                          child: Text("Пожертвование"),
                        ),
                      ],
                      controller: controllerTab,
                    ),
                  ),
                ],
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: Column(
                    children: [Text("аааааааа")],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      Column(
        children: [
          appBar(context),
          TabBody(
            custom.Card(
              Column(
                children: <Widget>[
                  ContributorLabel(
                    "Semyon Butenko",
                    nickname: "Laim0n",
                    avatarUrl:
                        'https://sun1-84.userapi.com/c856136/v856136189/7345e/Ht4mdQUJuu0.jpg',
                    additions: 100,
                    deletions: 22,
                  ),
                  ContributorLabel(
                    "Semyon Butenko",
                    nickname: "Laim0n",
                    avatarUrl:
                        'https://sun1-84.userapi.com/c856136/v856136189/7345e/Ht4mdQUJuu0.jpg',
                    additions: 100,
                    deletions: 22,
                  ),
                  ContributorLabel(
                    "Semyon Butenko",
                    nickname: "Laim0n",
                    avatarUrl:
                        'https://sun1-84.userapi.com/c856136/v856136189/7345e/Ht4mdQUJuu0.jpg',
                    additions: 100,
                    deletions: 22,
                  ),
                  ContributorLabel(
                    "Semyon Butenko",
                    nickname: "Laim0n",
                    avatarUrl:
                        'https://sun1-84.userapi.com/c856136/v856136189/7345e/Ht4mdQUJuu0.jpg',
                    additions: 100,
                    deletions: 22,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
