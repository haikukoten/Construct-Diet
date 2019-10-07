import 'dart:convert';

import 'package:construct_diet/common/buttons.dart' as custom;
import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/screen_body.dart';
import 'package:construct_diet/common/split_column.dart';
import 'package:construct_diet/storage/local_settings.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:construct_diet/web/api/http_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContributorsPage extends StatefulWidget {
  @override
  _ContributorsPageState createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Widget appBar(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Hero(
            tag: 'appbar',
            child: Material(
              elevation: 1.5,
              clipBehavior: Clip.antiAlias,
              shadowColor: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.all(Radius.circular(8.5)),
              color: Theme.of(context).cardColor,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
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
                  Padding(
                    padding: EdgeInsets.only(top: 36.5),
                    child: ButtonLabel(
                      Vocabluary.getWord('Contribute to the development'),
                      description: Vocabluary.getWord(
                          'Click here to go on project\'s GitHub page.'),
                      icon: MdiIcons.codeTags,
                      onPressed: () => launch(
                          'https://github.com/oneLab-Projects/Construct-Diet'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      Column(
        children: [
          appBar(context),
          Padding(
            padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
            child: Column(
              children: <Widget>[
                custom.Card(
                  InfoLabel(Vocabluary.getWord('Project\'s community'),
                      description: Vocabluary.getWord(
                          'Click on member to go on their GitHub page.'),
                      icon: MdiIcons.accountGroupOutline),
                ),
                custom.Card(ContributorsItems()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContributorsItems extends StatefulWidget {
  @override
  _ContributorsItemsState createState() => _ContributorsItemsState();
}

class _ContributorsItemsState extends State<ContributorsItems> {
  static List<Widget> labelsList = [];

  @override
  void initState() {
    super.initState();
    _showPlug(); // показать заглужку
    _showUsersFromLocal(); // получить участников с локального хранилища
    _updateUsers(); // обновить участников с сервера
  }

  _showPlug() {
    setState(() {
      labelsList = [
        ContributorShimmerLabel(),
        ContributorShimmerLabel(),
      ];
    });
  }

  Future _showUsersFromLocal() async {
    var container = await LocalSettings().getContainer('main');

    if (container.isVirtual) return;

    List<dynamic> list = container.getItem('contributors');

    if (list.length > 0) {
      _getUsersFromServer(list, true); // Обновляет список без фотографий
    }
  }

  void _getUsersFromServer(List<dynamic> list, bool isLocal) {
    list = _sortItems(list);

    List<Widget> labels = [];
    for (var i = 0; i < list.length; i++) {
      var item = list[i];

      String name;
      if (Vocabluary.getCurrentLanguage() == 'ru') {
        name = item['name']['ru'];
      } else {
        name = item['name']['en'];
      }

      labels.add(new ContributorLabel(
        _convertToUTF8(name),
        nickname: _convertToUTF8(item['nickname']),
        avatarUrl: isLocal == true ? null : item['avatar_uri'],
        additions: item['commits']['additions'],
        deletions: item['commits']['deletions'],
        onPressed: () async {
          String url = item['profile_uri'];
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
      ));
    }
    setState(() {
      labelsList = labels;
    });
  }

  Future _updateUsers() async {
    var githubRequest = await HTTPRequest().getFromUri(
        'https://api.github.com/repos/oneLab-Projects/Construct-Diet/stats/contributors',
        RequestType.GET);
    var onelabRequest = await HTTPRequest().getFromUri(
        'https://api.onelab.work/cd/developers.json', RequestType.GET);
    if (githubRequest.code != 200) return;

    List<dynamic> list = [];
    if (onelabRequest.code != 200)
      list = await _getItemsFromRequests(githubRequest);
    else
      list = await _getItemsFromCombineOfRequests(githubRequest, onelabRequest);
    if (list.length > 0) _getUsersFromServer(list, false);

    var container = await LocalSettings().getContainer('main');
    container.setItem('contributors', list);
    await container.saveContainer();
  }

  Future<List<dynamic>> _getItemsFromRequests(HTTPRequest r1) async {
    var list = r1.getContentLikeList();
    List<dynamic> outList = [];

    for (var i = 0; i < list.length; i++) {
      var r2 = await HTTPRequest()
          .getFromUri(list[i]['author']['url'], RequestType.GET);
      var map = r2.getContentLikeMap();
      if (r2.code == 200)
        list[i]['author'].putIfAbsent(
            'name',
            () => {
                  'ru': map['name'],
                  'en': map['name'],
                });
      outList.add(_parseToItem(list[i]));
    }

    return outList;
  }

  Future<List<dynamic>> _getItemsFromCombineOfRequests(
      HTTPRequest r1, HTTPRequest r2) async {
    var list = r1.getContentLikeList();
    var onelist = r2.getContentLikeList();

    for (var i = 0; i < list.length; i++) {
      for (var j = 0; j < onelist.length; j++) {
        if (list[i]['author']['login'] == onelist[j]['nickname']) {
          list[i]['author']
              .putIfAbsent('name', () => onelist[j]['displayName']);
        }
      }
    }

    List<dynamic> outList = [];
    for (var i = 0; i < list.length; i++) {
      if (list[i]['author'].containsKey('name') == false) {
        var r2 = await HTTPRequest()
            .getFromUri(list[i]['author']['url'], RequestType.GET);
        var map = r2.getContentLikeMap();

        if (r2.code == 200)
          list[i]['author'].putIfAbsent(
              'name',
              () => {
                    'ru': map['name'],
                    'en': map['name'],
                  });
      }
      outList.add(_parseToItem(list[i]));
    }

    return outList;
  }

  Map<dynamic, dynamic> _parseToItem(Map<dynamic, dynamic> map) {
    String nickname = map['author']['login'];
    String auri = map['author']['avatar_url'];
    String uri = map['author']['html_url'];
    String nameRu = map['author']['name']['ru'];
    String nameEn = map['author']['name']['en'];
    var adList = map['weeks'];

    return {
      'nickname': nickname,
      'profile_uri': uri,
      'avatar_uri': auri,
      'name': {'ru': nameRu, 'en': nameEn},
      'commits': {
        'additions': _getListTotal(adList, 'a'),
        'deletions': _getListTotal(adList, 'd')
      }
    };
  }

  int _getListTotal(List<dynamic> list, String key) {
    int out = 0;

    for (var i = 0; i < list.length; i++) {
      out += list[i][key];
    }

    return out;
  }

  String _convertToUTF8(String buffer) {
    List<int> encode = [];

    for (var i = 0; i < buffer.length; i++) {
      encode.add(buffer.codeUnitAt(i));
    }

    return utf8.decode(encode);
  }

  List<dynamic> _sortItems(List<dynamic> items) {
    items.sort((a, b) =>
        b['commits']['additions'].compareTo(a['commits']['additions']));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SplitColumn(
      children: labelsList,
    );
  }
}
