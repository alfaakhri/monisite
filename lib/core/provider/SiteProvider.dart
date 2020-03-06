import 'package:flutter/cupertino.dart';
import 'package:flutter_monisite/core/components/Failure.dart';
import 'package:flutter_monisite/core/models/Site.dart';
import 'package:flutter_monisite/core/models/SiteById.dart';
import 'package:flutter_monisite/core/service/ApiService.dart';

enum SiteState { initial, loading, loaded, unloaded }

class SiteProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Site> _site = List<Site>();
  List<Site> get sites => _site;
  void _setSites(dynamic res) {
    _site = res.map<Site>((json) {
      return Site.fromJson(json);
    }).toList();
    notifyListeners();
  }

  List<SiteById> _siteById = List<SiteById>();
  List<SiteById> get siteById => _siteById;
  void _setSiteById(dynamic res) {
    _siteById = res.map<SiteById>((json) {
      return SiteById.fromJson(json);
    }).toList();
    notifyListeners();
  }

  SiteState _state = SiteState.initial;
  SiteState get state => _state;
  void _setState(SiteState state) {
    _state = state;
    notifyListeners();
  }

  Failure _failure;
  Failure get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  void doFetchSiteList() async {
    _setState(SiteState.loading);
    try {
      await _apiService.fetchSites().then((dynamic res) {
        _setSites(res);
        _setState(SiteState.loaded);
      });
    } on Failure catch (f) {
      print("ini error " + f.toString());
      _setFailure(f);

      _setState(SiteState.unloaded);
    }
  }

  void doFetchSiteById(String id) async {
    _setState(SiteState.loading);
    try {
      await _apiService.getSiteById(id).then((dynamic res) {
        _setSiteById(res);
        _setState(SiteState.loaded);
      });
    } on Failure catch (f) {
      print("ini error " + f.toString());
      _setFailure(f);

      _setState(SiteState.unloaded);
    }
  }
}
