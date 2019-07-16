import 'package:scoped_model/scoped_model.dart';

class DataModel extends Model {
  bool _isSet = false;
  bool get isSet => _isSet;

  bool _isWoman = true;
  int _age = 18;
  int _height = 165;
  int _weight = 80;
  int _wrist;

  bool get isWoman => _isWoman;
  int get age => _age;
  int get height => _height;
  int get weight => _weight;
  int get wrist => _wrist;

  void increment() {
    save();
  }

  void save() {
    _isSet = true;
    notifyListeners();
  }
}
