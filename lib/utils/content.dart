import 'package:flutter/cupertino.dart';

bool isX(context) {
  final bool isIt = MediaQuery.of(context).size.height >= 812.0;
  return isIt;
}
