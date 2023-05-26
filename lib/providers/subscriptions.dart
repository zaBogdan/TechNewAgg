import 'package:flutter/material.dart';

class SubscriptionsProvider extends ChangeNotifier {
  final _subscriptions = <String>[];

  List<String> get subscriptions => _subscriptions;

  // void addSubscription(Subscription subscription) {
  //   _subscriptions.add(subscription);
  //   notifyListeners();
  // }

  // void removeSubscription(Subscription subscription) {
  //   _subscriptions.remove(subscription);
  //   notifyListeners();
  // }
}
