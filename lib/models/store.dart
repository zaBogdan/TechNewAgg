import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  SharedPreferences? _prefs;

  static final Store _instance = Store._internal();

  factory Store() => _instance;

  Future<void> _create(String key, dynamic data) async {
    _prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(data);
    await _prefs!.setString(key, jsonEncode(data));
  }

  Future<dynamic> _read(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    final data = _prefs!.getString(key);
    if (data == null) {
      return <String, dynamic>{};
    }
    return jsonDecode(data);
  }

  Future<void> _delete(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.remove(key);
  }

  Store._internal();

  static Future<dynamic> get(String key) async => Store._internal()._read(key);
  static Future<void> set(String key, dynamic value) async =>
      Store._internal()._create(key, value);

  static Future<void> delete(String key) async =>
      Store._internal()._delete(key);
}
