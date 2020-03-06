import 'package:flutter/cupertino.dart';
import 'package:flutter_monisite/core/models/Site.dart';

enum StatusState { stabil, inprogress, unstabil }

class StatusMonitorProvider extends ChangeNotifier {
  void checkStatusMonitor(List<Site> site) {
    site.forEach((f) {
      
    });
  }
}
