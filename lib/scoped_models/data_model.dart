import 'package:scoped_model/scoped_model.dart';

class DataModel extends Model {
  bool _isSet = false;
  bool get isSet => _isSet;

  int _genderIndex = 0;
  int _ageIndex = 13;
  int _heightIndex = 60;
  int _weightIndex = 35;
  int _wristIndex = 2;

  bool _isWoman = true;
  int _age = 25;
  int _height = 160;
  int _weight = 65;
  int _wrist = 15;

  int get genderIndex => _genderIndex;
  int get ageIndex => _ageIndex;
  int get heightIndex => _heightIndex;
  int get weightIndex => _weightIndex;
  int get wristIndex => _wristIndex;

  bool get isWoman => _isWoman;
  int get age => _age;
  int get height => _height;
  int get weight => _weight;
  dynamic get wrist {
    dynamic value = _wrist;
    if (_wrist == 14 && isWoman) {
      value = "Меньше 15";
    }

    if (_wrist == 18 && isWoman) {
      value = "Больше 17";
    }

    if (_wrist == 17 && !isWoman) {
      value = "Меньше 18";
    }

    if (_wrist == 21 && !isWoman) {
      value = "Больше 20";
    }

    return value;
  }

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
