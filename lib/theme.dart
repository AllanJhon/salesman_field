import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

int themeIndex = 0;

final List<Color> themeList = [
  Colors.black,
  Colors.red,
  Colors.teal,
  Colors.pink,
  Colors.amber,
  Colors.orange,
  Colors.green,
  Colors.blue,
  Colors.lightBlue,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.cyan,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey
];

abstract class ThemeStateModel extends Model {
 
  int _themeIndex;
  get themeIndex => _themeIndex;
 
  void changeTheme(int themeIndex) async {
    _themeIndex = themeIndex;
    notifyListeners();
  }
}
