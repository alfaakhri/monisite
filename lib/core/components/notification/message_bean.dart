//Model class to represent the message return by FCM
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_monisite/core/components/notification/detail_page_notif.dart';

class MessageBean {
  final String itemId;
  final Map<String, MessageBean> items;
  MessageBean(this.itemId, this.items);

  StreamController<MessageBean> _controller =
      StreamController<MessageBean>.broadcast();

  Stream<MessageBean> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => DetailPageNotif(
          itemId: itemId,
          items: items,
        ),
      ),
    );
  }
}
