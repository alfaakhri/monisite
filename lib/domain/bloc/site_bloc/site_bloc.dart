import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_monisite/data/models/monitor/monitor_model.dart';
import 'package:flutter_monisite/data/models/monitor/report_monitor_model.dart';
import 'package:flutter_monisite/data/models/site/list_sites_model.dart';
import 'package:flutter_monisite/data/repository/api_service.dart';
import 'package:flutter_monisite/external/service/shared_preference_service.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'site_event.dart';
part 'site_state.dart';

class SiteBloc extends Bloc<SiteEvent, SiteState> {
  SiteBloc() : super(SiteInitial());
  ApiService _apiService = ApiService();
  SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  ListSitesModel _listSites = ListSitesModel();
  ListSitesModel get listSites => _listSites;
  void setListSites(ListSitesModel listSites) {
    _listSites = listSites;
  }

  ListSitesModel _sitesResultSearch = ListSitesModel();
  ListSitesModel get sitesResultSearch => _sitesResultSearch;
  void setSitesResultSearch(ListSitesModel sitesResultSearch) {
    _sitesResultSearch = sitesResultSearch;
  }

  MonitorModel _dataMonitor = MonitorModel();
  MonitorModel get dataSite => _dataMonitor;
  void setDataSite(MonitorModel dataMonitor) {
    _dataMonitor = dataMonitor;
  }

  ReportMonitorModel _reportMonitor = ReportMonitorModel();
  ReportMonitorModel get reportMonitor => _reportMonitor;
  void setReportMonitor(ReportMonitorModel reportMonitor) {
    _reportMonitor = reportMonitor;
  }

  String _status = "";
  String get status => _status;
  void setStatus(String status) {
    _status = status;
  }

  String _token = "";
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  Stream<SiteState> mapEventToState(
    SiteEvent event,
  ) async* {
    if (event is GetSites) {
      yield GetSitesLoading();
      try {
        var tokenNew = await _sharedPreferenceService.getToken();
        if (tokenNew == null) {
          yield SiteMustLogin();
        } else {
          _token = tokenNew;
          var response = await _apiService.getSitesNew(_token);
          if (response.statusCode == 200) {
            _listSites = ListSitesModel.fromJson(response.data);
            if (_listSites.data?.length == 0) {
              yield GetSitesEmpty();
            } else {
              yield GetSitesSuccess(_listSites);
            }
          } else if (response.statusCode == 401) {
            yield SiteMustLogin();
          } else {
            yield GetSitesFailed("Failed get data sites");
          }
        }
      } catch (e) {
        yield GetSitesFailed(e.toString());
      }
    } else if (event is GetSiteByID) {
      yield GetSiteByIDLoading();
      try {
        var tokenNew = await _sharedPreferenceService.getToken();
        if (tokenNew == null) {
          yield SiteMustLogin();
        } else {
          _token = tokenNew;

          var response = await _apiService.getSiteByID(event.siteId, _token);
          if (response!.statusCode == 200) {
            _dataMonitor = MonitorModel.fromJson(response.data);
            if (_dataMonitor.success ?? false) {
              checkStatus(_dataMonitor);
              yield GetSiteByIDSuccess(_dataMonitor);
            } else {
              yield GetSiteByIDEmpty(_dataMonitor.message!);
            }
          } else {
            yield GetSiteByIDFailed("Failed get data monitor");
          }
        }
      } catch (e) {
        yield GetSiteByIDFailed(e.toString());
      }
    } else if (event is GetSiteBySearch) {
      yield GetSiteBySearchLoading();

      try {
        var tokenNew = await _sharedPreferenceService.getToken();
        if (tokenNew == null) {
          yield SiteMustLogin();
        } else {
          _token = tokenNew;
          var response =
              await _apiService.getSitesBySearch(event.result, _token);
          if (response!.statusCode == 200) {
            _sitesResultSearch = ListSitesModel.fromJson(response.data);
            if (_sitesResultSearch.data?.length == 0) {
              yield GetSiteBySearchEmpty();
            } else {
              yield GetSiteBySearchSuccess(_sitesResultSearch);
            }
          } else {
            yield GetSiteBySearchFailed("Failed get data sites");
          }
        }
      } catch (e) {
        yield GetSiteBySearchFailed(e.toString());
      }
    } else if (event is GetReportMonitor) {
      yield GetReportMonitorLoading();
      try {
        var tokenNew = await _sharedPreferenceService.getToken();
        if (tokenNew == null) {
          yield SiteMustLogin();
        } else {
          _token = tokenNew;
          DateTime toDate = DateTime.parse(event.toDate);

          var response = await _apiService.getReportMonitor(
              event.siteId,
              DateFormat('yyyy-MM-dd').format(DateTime.parse(event.fromDate)),
              DateFormat('yyyy-MM-dd').format(toDate),
              _token);
          if (response!.statusCode == 200) {
            _reportMonitor = ReportMonitorModel.fromJson(response.data);
            if (_reportMonitor.data!.length == 0) {
              yield GetReportMonitorEmpty();
            } else {
              yield GetReportMonitorSuccess(_reportMonitor);
            }
          } else {
            yield GetReportMonitorFailed("Failed get data report");
          }
        }
      } catch (e) {
        yield GetReportMonitorFailed(e.toString());
      }
    }
  }

  void checkStatus(MonitorModel monitor) {
    if (double.parse(monitor.data!.teganganRs!) < 100.00 ||
        double.parse(monitor.data!.teganganRs!) > 250.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.data!.teganganRt!) < 100.00 ||
        double.parse(monitor.data!.teganganRt!) > 250.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.data!.teganganSt!) < 100.00 ||
        double.parse(monitor.data!.teganganSt!) > 250.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.data!.teganganRn!) < 100.00 ||
        double.parse(monitor.data!.teganganRn!) > 250.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.data!.teganganSn!) < 100.00 ||
        double.parse(monitor.data!.teganganSn!) > 250.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.data!.teganganTn!) < 100.00 ||
        double.parse(monitor.data!.teganganTn!) > 250.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.data!.arusR!) < 0.00 ||
        double.parse(monitor.data!.arusS!) < 0.00 ||
        double.parse(monitor.data!.arusT!) < 0.00 ||
        double.parse(monitor.data!.arusAc!) < 0.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.data!.pressure!) < 80.00 ||
        double.parse(monitor.data!.pressure!) > 140.00) {
      setStatus("Perlu ditinjau");
    } else if (double.parse(monitor.data!.temperature!) > 27.00) {
      setStatus("Perlu ditinjau");
    } else {
      setStatus("Stabil");
    }
  }
}
