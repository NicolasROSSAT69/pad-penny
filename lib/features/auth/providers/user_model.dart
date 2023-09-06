import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {

  String _useruid = "Inconnu";
  String _userEmail = "Inconnu";
  String _userName = "Inconnu";

  String get userId => _useruid;
  String get userEmail => _userEmail;
  String get userName => _userName;

  void setUserEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void setUserUid(String uid) {
    _useruid = uid;
    notifyListeners();
  }

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}
