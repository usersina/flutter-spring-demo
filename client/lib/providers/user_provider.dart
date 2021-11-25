import 'dart:async';

import 'package:client/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  final _streamController = StreamController<User?>();

  Stream<User?> get loggedUser$ {
    return _streamController.stream;
  }

  setNextStreamValue(User? user) {
    _streamController.add(user);
  }
}
