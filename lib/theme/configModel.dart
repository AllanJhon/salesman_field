import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import '../untils/shared_preferences.dart' show SpUtil;

class ConfigInfo {
  String theme = 'red';
}

class ConfigModel extends ConfigInfo with ChangeNotifier {
  Future $setTheme(payload) async {
    theme = payload;
    SpUtil.putString('theme', payload);
    notifyListeners();
  }

  Future $getTheme() async {
    String _theme = await SpUtil.getString('theme');
    $setTheme(_theme == null ? "red" : _theme);
  }
}
