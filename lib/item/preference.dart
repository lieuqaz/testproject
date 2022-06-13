import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/object_modle.dart';

class SharedPreferenceUtils {
  void init(object, listResult) async {
    await saveObject('object', object);
    await saveResult(listResult);
  }

  Future<void> saveObject(String key, String object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, object);
    print('ok');
  }

  Future<void> saveResult(List<ObjectModel> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _list = [];
    _list = prefs.getStringList('result') ?? [];
    // _list!.add(jsonEncode(list[0]));
    _list.add(jsonEncode(list[0]));
    await prefs.setStringList('result', _list);
  }
  // Future<void> saveResult(List<ObjectModel> list) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('result', jsonEncode(list));
  // }

  Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
