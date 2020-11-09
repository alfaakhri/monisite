import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  bool _newNotification = false;
  bool get newNotify => _newNotification;

  void setNotify(bool notify) {
    _newNotification = notify;
    notifyListeners();
  }
}
