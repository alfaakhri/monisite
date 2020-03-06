//Detail UI screen that will display the content of the message return from FCM
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_monisite/core/components/notification/message_bean.dart';

class DetailPageNotif extends StatefulWidget {
  final String itemId;
  final Map<String, MessageBean> items;

  const DetailPageNotif({Key key, this.itemId, this.items}) : super(key: key);

  @override
  _DetailPageNotif createState() => _DetailPageNotif();
}

class _DetailPageNotif extends State<DetailPageNotif> {
  MessageBean _item;
  StreamSubscription<MessageBean> _subscription;

  @override
  void initState() {
    super.initState();
    _item = widget.items[widget.itemId];
    _subscription = _item.onChanged.listen((MessageBean item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item ${_item.itemId}"),
      ),
      body: Material(
        child: Center(child: Text("Item status: ${_item.status}")),
      ),
    );
  }
}