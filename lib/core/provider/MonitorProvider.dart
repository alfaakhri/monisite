import 'package:flutter/cupertino.dart';
import 'package:flutter_monisite/core/components/Failure.dart';
import 'package:flutter_monisite/core/models/Monitor.dart';
import 'package:flutter_monisite/core/models/Site.dart';
import 'package:flutter_monisite/core/service/ApiService.dart';

enum MonitorState { initial, loading, loaded, unloaded }

class MonitorProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  String _status;
  String get status => _status;
  void setStatus(String status) {
    _status = status;
    notifyListeners();
  }

  MonitorState _state = MonitorState.initial;
  MonitorState get state => _state;
  void _setState(MonitorState state) {
    _state = state;
    notifyListeners();
  }

  // Failure _failure;
  // Failure get failure => _failure;
  // void _setFailure(Failure failure) {
  //   _failure = failure;
  //   notifyListeners();
  // }

  String _failure;
  String get failure => _failure;
  void _setFailure(String failure) {
    _failure = failure;
    notifyListeners();
  }

  List<Monitor> _monitor = List<Monitor>();
  List<Monitor> get monitor => _monitor;
  void _setMonitor(dynamic res) {
    _monitor = res.map<Monitor>((json) {
      return Monitor.fromJson(json);
    }).toList();
    checkStatus(_monitor);
    notifyListeners();
  }

  void checkStatus(List<Monitor> monitor) {
    if (int.parse(monitor.single.volt1) < 100 ||
        int.parse(monitor.single.volt1) > 250) {
      setStatus("Perlu ditinjau");
    } else if (int.parse(monitor.single.volt2) < 100 ||
        int.parse(monitor.single.volt2) > 250) {
      setStatus("Perlu ditinjau");
    } else if (int.parse(monitor.single.volt3) < 100 ||
        int.parse(monitor.single.volt3) > 250) {
      setStatus("Perlu ditinjau");
    } else if (int.parse(monitor.single.volt4) < 100 ||
        int.parse(monitor.single.volt4) > 250) {
      setStatus("Perlu ditinjau");
    } else if (int.parse(monitor.single.volt5) < 100 ||
        int.parse(monitor.single.volt5) > 250) {
      setStatus("Perlu ditinjau");
    } else if (int.parse(monitor.single.volt6) < 100 ||
        int.parse(monitor.single.volt6) > 250) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.single.curr1) < 0.00 ||
        double.parse(monitor.single.curr2) < 0.00 ||
        double.parse(monitor.single.curr3) < 0.00 ||
        double.parse(monitor.single.currAirCon) < 0.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.single.pressure) < 80.00 ||
        double.parse(monitor.single.pressure) > 140.00) {
      setStatus("Perlu ditinjau");
    } else if (int.parse(monitor.single.temperature) > 27) {
      setStatus("Perlu ditinjau");
    } else {
      setStatus("Stabil");
    }
  }

  void doFetchMonitor(String id) async {
    _setState(MonitorState.loading);
    try {
      await _apiService.fetchMonitor(id).then((dynamic res) {
        if (res == null) {
          _setState(MonitorState.unloaded);
        }
        _setMonitor(res);
        _setFailure(null);
        _setState(MonitorState.loaded);
      });
    } on Failure catch (f) {
      print("ini error " + f.toString());
      _setFailure(f.toString());
      setStatus("Belum Terpasang");

      _setState(MonitorState.unloaded);
    }
  }
}
