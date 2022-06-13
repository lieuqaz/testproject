import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/object_modle.dart';

class SharedPreferenceUtils {
  void init(object, objectModel, listResult) async {
    await saveObject('object', object);
    await saveResult(listResult);
  }

  Future<void> saveObject(String key, String object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, object);
  }

  Future<void> saveResult(List<ObjectModel> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('result', jsonEncode(list));
  }

  Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
