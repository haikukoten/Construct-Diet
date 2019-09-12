import 'package:construct_diet/common/diet.dart';
import 'package:construct_diet/common/labels.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataModel extends Model {
  String language;

  bool _isSet = false;
  bool _isOpenedDiet = false;
  bool get isSet => _isSet;
  bool get isOpenedDiet => _isOpenedDiet;

  int _genderIndex = 0;
  int _ageIndex = 13;
  int _heightIndex = 60;
  int _weightIndex = 20;

  bool _isWoman = true;
  int _age = 25;
  int _height = 160;
  int _weight = 50;

  int get genderIndex => _genderIndex;
  int get ageIndex => _ageIndex;
  int get heightIndex => _heightIndex;
  int get weightIndex => _weightIndex;

  bool get isWoman => _isWoman;
  int get age => _age;
  int get height => _height;
  int get weight => _weight;

  int _idealWeight = 0;
  int _minWeight = 0;
  int _maxWeight = 0;
  int _overweight = 0;
  double _imt = 0;

  int get idealWeight => _idealWeight;
  int get minWeight => _minWeight;
  int get maxWeight => _maxWeight;
  int get overweight => _overweight;
  double get imt => _imt;

  void setGender(dynamic value, int index) {
    _isWoman = index == 0;
    _genderIndex = index;
  }

  void setAge(int value, int index) {
    _age = value;
    _ageIndex = index;
  }

  void setHeight(int value, int index) {
    _height = value;
    _heightIndex = index;
  }

  void setWeight(int value, int index) {
    _weight = value;
    _weightIndex = index;
  }

  getStatus() {
    if (imt < 16) return 0;
    if (imt >= 16 && imt < 18.5) return 1;
    if (imt >= 18.5 && imt < 24.9) return 2;
    if (imt >= 24.9 && imt < 29.9) return 3;
    if (imt >= 29.9 && imt < 34.9) return 4;
    if (imt >= 34.9 && imt <= 39.9) return 5;
    if (imt >= 39.9) return 6;
  }

  void save() {
    _isSet = true;
    int heightft = ((height * 0.3937008) / 12).floor();
    double heightinch = ((height * 0.3937008) % 12);

    double inchConv = ((heightft * 12) + heightinch) / 39.373533;
    _minWeight = (inchConv * inchConv * 18.5).floor() + 1;
    _maxWeight = (inchConv * inchConv * 25).floor();

    double heightm = height * 0.01;
    _imt = weight / (heightm * heightm);

    _idealWeight = isWoman
        ? (45.5 + ((((heightft * 12) + heightinch) - 60) * 2.3)).floor()
        : (50 + ((((heightft * 12) + heightinch) - 60) * 2.3)).floor();

    _overweight = weight - idealWeight;
    if (_overweight < 0) _overweight = 0;

    notifyListeners();
    saveToStorage();
  }

  void saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('isSet', _isSet);
    prefs.setBool('isOpenedDiet', _isOpenedDiet);
    prefs.setString('language', language);

    prefs.setInt('genderIndex', _genderIndex);
    prefs.setInt('ageIndex', _ageIndex);
    prefs.setInt('heightIndex', _heightIndex);
    prefs.setInt('weightIndex', _weightIndex);

    prefs.setBool('isWoman', _isWoman);
    prefs.setInt('age', _age);
    prefs.setInt('height', _height);
    prefs.setInt('weight', _weight);

    prefs.setString('sortPositive', sortPositive.join(","));
    prefs.setString('sortNegative', sortNegative.join(","));
  }

  void loadToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    language = prefs.getString('language');

    if (prefs.getBool('isSet') == null) return;
    _isSet = prefs.getBool('isSet');
    _isOpenedDiet = prefs.getBool('isOpenedDiet');

    _genderIndex = prefs.getInt('genderIndex');
    _ageIndex = prefs.getInt('ageIndex');
    _heightIndex = prefs.getInt('heightIndex');
    _weightIndex = prefs.getInt('weightIndex');

    _isWoman = prefs.getBool('isWoman');
    _age = prefs.getInt('age');
    _height = prefs.getInt('height');
    _weight = prefs.getInt('weight');

    sortPositive = prefs
        .getString('sortPositive')
        .split(",")
        .map((i) => int.tryParse(i))
        .toList();
    sortNegative = prefs
        .getString('sortNegative')
        .split(",")
        .map((i) => int.tryParse(i))
        .toList();

    save();
  }

  Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void closeTip() async {
    final prefs = await SharedPreferences.getInstance();

    _isOpenedDiet = true;
    prefs.setBool('isOpenedDiet', _isOpenedDiet);
  }

  List<Diet> dietList;

  generateDietWidgetList() {
    if (!isSet || overweight < 4) {
      _widgetGoodDiet = null;
      _widgetDietList = [];
      return;
    }

    _sortedDietList = _getDiets();
    if (_sortedDietList == null) {
      _widgetGoodDiet = null;
      _widgetDietList = [];
      return;
    }

    _widgetDietList = List<Widget>.generate(
      _sortedDietList.length - 1,
      (int i) {
        i += 1;
        var diet = _sortedDietList[i];
        return DietLabel(diet);
      },
    );
    if (_widgetDietList.length == 0) {
      _widgetGoodDiet = null;
      _widgetDietList = [];
      return;
    }

    if (_widgetDietList.length == 1) _widgetDietList = [];

    var diet = _sortedDietList[0];
    _widgetGoodDiet = DietLabel(diet);
  }

  Widget _widgetGoodDiet;
  Widget get widgetGoodDiet => _widgetGoodDiet;

  List<Widget> _widgetDietList = List<Widget>();
  List<Widget> get widgetDietList => _widgetDietList;

  List<Diet> _sortedDietList;

  List<Diet> _getDiets() {
    List<Diet> list = List.from(dietList);
    for (Diet diet in dietList) {
      list.remove(diet);
      if ((diet.efficiency < overweight) && diet.efficiency < 8) continue;

      if (sortNegative.toSet().intersection(diet.category.toSet()).length != 0)
        continue;

      diet.positiveIndex = (diet.efficiency - overweight) - diet.duration;
      if (diet.positiveIndex > 0) diet.positiveIndex *= -1;

      if (sortPositive != null)
        diet.positiveIndex +=
            sortPositive.toSet().intersection(diet.category.toSet()).length *
                10;

      list.add(diet);
    }

    if (list.length == 0) return null;
    if (list.length == 1) return list;

    list.sort((Diet a, Diet b) =>
        a.duration > b.duration || a.efficiency > b.efficiency ? 1 : -1);
    list.sort((Diet a, Diet b) => b.positiveIndex.compareTo(a.positiveIndex));

    int minIndex = list[list.length - 1].positiveIndex;

    for (int i = 0; i < list.length; i++) {
      list[i].positiveIndex += -minIndex - i;
    }

    minIndex = list[list.length - 1].positiveIndex;

    for (int i = 0; i < list.length; i++) {
      list[i].positiveIndex += -minIndex;
    }

    int maxIndex = list[0].positiveIndex + -minIndex;

    for (Diet diet in list) {
      diet.positiveIndex = (diet.positiveIndex * (1 / maxIndex) * 100).floor();
    }

    return list;
  }

  int getPositiveOrNegative(int id) {
    if (sortPositive.contains(id)) return 1;
    if (sortNegative.contains(id)) return 2;
    return 0;
  }

  void addFavorite(int id, int value) {
    if (sortPositive.contains(id) || sortNegative.contains(id)) {
      sortPositive.remove(id);
      sortNegative.remove(id);
    }

    switch (value) {
      case 1:
        sortPositive.add(id);
        break;
      case 2:
        sortNegative.add(id);
        break;
    }
    save();
  }

  List<int> sortPositive = List<int>();
  List<int> sortNegative = List<int>();
}
