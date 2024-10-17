import 'package:flutter/material.dart';

class DemoProvider extends ChangeNotifier {
  String _user = 'Lakshay';

  String get user => _user;

  set user(String newUser) {
    _user = newUser;
    notifyListeners(); // Notify listeners whenever the user changes
  }

  List<String> name = ['Name 1', 'Name 2'];
}
