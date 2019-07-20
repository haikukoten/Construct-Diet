import 'package:scoped_model/scoped_model.dart';

class DataModel extends Model {
  bool _isSet = false;
  bool get isSet => _isSet;

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

  getStatus() {
    if (imt < 16) return 0;
    if (imt >= 16 && imt < 18.5) return 1;
    if (imt >= 18.5 && imt < 25) return 2;
    if (imt >= 25 && imt < 30) return 3;
    if (imt >= 30 && imt < 35) return 4;
    if (imt >= 35 && imt <= 40) return 5;
    if (imt >= 40) return 6;
  }

  void save() {
    _isSet = true;
    int heightft = ((height * 0.3937008) / 12).floor();
    double heightinch = ((height * 0.3937008) % 12);

    _idealWeight = isWoman
        ? (45.5 + ((((heightft * 12) + heightinch) - 60) * 2.3)).floor()
        : (50 + ((((heightft * 12) + heightinch) - 60) * 2.3)).floor();

    var inchConv = ((heightft * 12) + heightinch) / 39.373533;
    _minWeight = (inchConv * inchConv * 18.5).floor() + 1;
    _maxWeight = (inchConv * inchConv * 25).floor();

    var heightm = height * 0.01;
    _imt = weight / (heightm * heightm);

    _overweight = weight - idealWeight;
    if (_overweight < 0) _overweight = 0;

    notifyListeners();
  }
}
