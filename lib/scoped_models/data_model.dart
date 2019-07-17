import 'package:scoped_model/scoped_model.dart';

class DataModel extends Model {
  bool _isSet = false;
  bool get isSet => _isSet;

  int _genderIndex = 0;
  int _ageIndex = 0;
  int _heightIndex = 0;
  int _weightIndex = 0;
  int _wristIndex = 0;

  bool _isWoman = true;
  int _age = 18;
  int _height = 165;
  int _weight = 80;
  int _wrist;

  int get genderIndex => _genderIndex;
  int get ageIndex => _ageIndex;
  int get heightIndex => _heightIndex;
  int get weightIndex => _weightIndex;
  int get wristIndex => _wristIndex;

  bool get isWoman => _isWoman;
  int get age => _age;
  int get height => _height;
  int get weight => _weight;
  int get wrist => _wrist;

  void setGender(dynamic value, int index) {
    _isWoman = index == 0;
    _genderIndex = index;
    save();
  }

  void setAge(int value, int index) {
    _age = value;
    _ageIndex = index;
    save();
  }

  void setHeight(int value, int index) {
    _height = value;
    _heightIndex = index;
    save();
  }

  void setWeight(int value, int index) {
    _weight = value;
    _weightIndex = index;
    save();
  }

  void setWrist(int value, int index) {
    _wrist = value;
    _wristIndex = index;
    save();
  }

  void save() {
    _isSet = true;
    notifyListeners();
  }
}
