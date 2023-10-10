import 'package:flutter/foundation.dart';

import 'package:gadget_express/components/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void updateUser(User? user) {
    _user = user;
    notifyListeners();
  }
}