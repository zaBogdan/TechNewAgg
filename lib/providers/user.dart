import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:technewsagg/models/settings.dart';
import 'package:technewsagg/models/user.dart';

import 'package:technewsagg/models/store.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  User? _current;
  User? get currentUser => _current;
  final maximumUsers = 5;

  Future<List<User>> _fetchUsers() async {
    final users = await Store.get("users");
    print(users);
    if (users.runtimeType == List) {
      return (users as List).map((e) => User.fromJson(e)).toList();
    }
    return [];
  }

  Future<bool> _addNewUser(User user) async {
    List<User> users = await _fetchUsers();
    if (users.length > 5) {
      Logger.root.info("User limit reached. You already have 5 accounts");
      return false;
    }
    users.add(user);
    await Store.set("users", users);
    notifyListeners();
    return true;
  }

  Future<bool> _updateUser(User user) async {
    List<User> users = await _fetchUsers();
    Logger.root.info("Fetched users: $users");
    users[users.indexWhere((element) => element.id == user.id)] = user;
    await Store.set("users", users);
    notifyListeners();
    return true;
  }

  Future<bool> canCreateMoreUsers(List<User> userList) async =>
      (await _fetchUsers()).length < maximumUsers;

  Future<Map<String, dynamic>> getAllUsers() async {
    final users = await _fetchUsers();

    return {
      'users': users,
      'canCreateMoreUsers': await canCreateMoreUsers(users),
    };
  }

  void setCurrentUser(User user) {
    _current = user;
  }

  Future<bool> isFirstTime() async =>
      await Settings.fromJson(await Store.get('settings')).firstTime == true;

  Future<bool> save(User user) async {
    final users = await _fetchUsers();
    if (users.any((element) => element.id == user.id)) {
      Logger.root.info("User already exists. Updating user");
      return await _updateUser(user);
    }

    Logger.root.info("User does not exist. Adding user");
    return await _addNewUser(user);
  }

  Future<bool> delete(User user) async {
    final users = await _fetchUsers();
    users.removeWhere((element) => element.id == user.id);
    await Store.set("users", users);
    notifyListeners();
    return true;
  }
}
