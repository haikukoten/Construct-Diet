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
  TabController controllerTab;

  @override
  void initState() {
    super.initState();
    controllerTab = TabController(length: 2, vsync: this);
    controllerTab.addListener(() {});
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17, 16, 17, 6),
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
                      iconSize: Theme.of(context).platform == TargetPlatform.iOS
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

//------------------------ ContributorsItems --------------------------------

class ContributorsItems extends StatefulWidget {
  @override
  _ContributorsItemsState createState() => _ContributorsItemsState();
}

class _ContributorsItemsState extends State<ContributorsItems> {
  static List<Widget> labelsList = [];

  @override
  void initState() {
    super.initState();

    _setShimmerLabels(); // Обновляет список виджетов на виджеты загрузки
    _setLablesFromLocal(); // Обновляет список виджетов из локальных настроек
    _updateLables(); // Обновляет локальные настройки и обновляет список виджетов из локальных настроек
  }

  _setShimmerLabels() {
    setState(() {
      labelsList = [
        ContributorShimmerLabel(),
        ContributorShimmerLabel(),
      ];
    });
  }

  Future _setLablesFromLocal() async {
    // Получает доступ к локальному контейнеру
    var container = await LocalSettings().getContainer('main');

    if (container.isVirtual) { // Если файл только в оперативной памяти
      return;
    }

    List<dynamic> list = container.getItem('contributors'); // Получает елемент по ключу из контейнера
    
    if (list.length > 0) { // Если в списке есть елементы
      _setLabels(list, true); // Обновляет список без фотографий
    }
  }

  void _setLabels(List<dynamic> list, bool isLocal) { // Добавляет виджеты исходя из данных list
    List<Widget> labels = [];
    for (var i = 0; i < list.length; i++) { 
      var item = list[i];

      String name;
      if (Vocabluary.getCurrentLanguage() == 'ru') {
        name = item['name']['ru'];
      }
      else {
        name = item['name']['en'];
      }

      labels.add(new ContributorLabel(
        toUFT8(name),
        nickname: toUFT8(item['nickname']),
        avatarUrl: isLocal == true
          ? null
          : item['avatar_uri'],
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

    setState(() { // Обновляет список
      labelsList = labels;
    });
  }

  Future _updateLables() async { // Обновляет локальные настройки и обновляет список виджетов из локальных настроек
    // Запросы на два api рессурса (github, onelab)
    var githubRequest = await HTTPRequest().getFromUri('https://api.github.com/repos/oneLab-Projects/Construct-Diet/stats/contributors', RequestType.GET);
    var onelabRequest = await HTTPRequest().getFromUri('https://api.onelab.work/cd/developers.json', RequestType.GET);

    if (githubRequest.code != 200) { // Если ошибка то функция обрывается
      return;
    }

    List<dynamic> list = [];
    if (onelabRequest.code != 200) { // Если ошибка то парсится без onelab request
      list = await _getItemsFromRequests(githubRequest);
    }
    else {
      list = await _getItemsFromCombineOfRequests(githubRequest, onelabRequest);
    }

    if (list.length > 0) { // Если в списке есть елементы
      _setLabels(list, false); // Обновляет список с фотографиями
    }

    // Получает доступ к локальному контейнеру
    var container = await LocalSettings().getContainer('main');
    container.setItem('contributors', list); // Сохраняет елементы в virtual

    await container.saveContainer(); // Сохраняет койтейнер
  }

  Future<List<dynamic>> _getItemsFromRequests(HTTPRequest r1) async {
    var list = r1.getContentLikeList();
    List<dynamic> outList = [];
    for (var i = 0; i < list.length; i++) { // Присваевает имя елементу
      var r2 = await HTTPRequest().getFromUri(list[i]['author']['url'], RequestType.GET);
      var map = r2.getContentLikeMap();

      if (r2.code == 200) {
        list[i]['author'].putIfAbsent('name', () => {
          'ru': map['name'],
          'en': map['name'],
        });
      }

      outList.add(_parceToItem(list[i]));
    }

    return outList;
  }

  Future<List<dynamic>> _getItemsFromCombineOfRequests(HTTPRequest r1, HTTPRequest r2) async {
    var list = r1.getContentLikeList();
    var onelist = r2.getContentLikeList();

    for (var i = 0; i < list.length; i++) { // Пытается присвоить имя елементу если логины в двух requests совпадают
      for (var j = 0; j < onelist.length; j++) {
        if (list[i]['author']['login'] == onelist[j]['nickname']) {
          list[i]['author'].putIfAbsent('name', () => onelist[j]['displayName']);
        }
      }
    }

    List<dynamic> outList = [];
    for (var i = 0; i < list.length; i++) { // Присваевает имя елементу у которых логины не совпали с onelab request
      if (list[i]['author'].containsKey('name') == false) {
        var r2 = await HTTPRequest().getFromUri(list[i]['author']['url'], RequestType.GET);
        var map = r2.getContentLikeMap();

        if (r2.code == 200) {
          list[i]['author'].putIfAbsent('name', () => {
            'ru': map['name'],
            'en': map['name'],
          });
        }
      }

      outList.add(_parceToItem(list[i]));
    }

    return outList;
  }

  Map<dynamic, dynamic> _parceToItem(Map<dynamic, dynamic> map) { // Парсит github request + onelab request в json формат виджета
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
      'name': {
        'ru': nameRu,
        'en': nameEn
      },
      'commits': {
        'additions': _getListTotal(adList, 'a'),
        'deletions': _getListTotal(adList, 'd')
      }
    };
  }

  int _getListTotal(List<dynamic> list, String key) // Получает сумму ключей в списке
  {
    int out = 0;

    for (var i = 0; i < list.length; i++) {
      out += list[i][key];
    }

    return out;
  }

  String toUFT8(String buffer)
  {
    List<int> encode = [];

    for (var i = 0; i < buffer.length; i++) {
      encode.add(buffer.codeUnitAt(i));
    }

    return utf8.decode(encode);
  }

  @override
  Widget build(BuildContext context) {
    return SplitColumn(
      children: labelsList,
    );
  }
}
