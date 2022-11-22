// import 'package:flutter_monisite/core/components/notification/message_bean.dart';

// class ItemMessage {
//   final Map<String, MessageBean> items = <String, MessageBean>{};
  
//   MessageBean itemForMessage(Map<String, dynamic> message) {
//     //If the message['data'] is non-null, we will return its value, else return map message object
//     final dynamic data = message['data'] ?? message;
//     final String itemId = data['id'];
//     final MessageBean item = items.putIfAbsent(
//         itemId, () => MessageBean(itemId, items))
//       ..status = data['status'];
//     return item;
//   }
// }