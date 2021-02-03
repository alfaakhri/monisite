import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_monisite/data/models/monitor/monitor_model.dart';
import 'package:flutter_monisite/data/models/monitor/report_monitor_model.dart';
import 'package:flutter_monisite/data/repository/api_service.dart';
import 'package:flutter_monisite/external/service/shared_preference_service.dart';
import 'package:meta/meta.dart';

part 'list_report_event.dart';
part 'list_report_state.dart';

class ListReportBloc extends Bloc<ListReportEvent, ListReportState> {
  ListReportBloc() : super(ListReportInitial());
  ApiService _apiService = ApiService();
  SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  ReportMonitorModel _listReport = ReportMonitorModel();
  ReportMonitorModel get listReport => _listReport;
  void setListReport(List<DataMonitor> listReport) {
    _listReport.data.addAll(listReport);
  }

  String _token;
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  @override
  Stream<ListReportState> mapEventToState(
    ListReportEvent event,
  ) async* {
    if (event is GetListReport) {
      yield GetListReportLoading();
      try {
        var tokenNew = await _sharedPreferenceService.getToken();
        if (tokenNew == null) {
          yield SiteMustLogin();
        } else {
          _token = tokenNew;

          var response = await _apiService.getReportListMonitor(event.siteId,
              event.fromDate, event.toDate, _token, event.pageIndex);
          if (response.statusCode == 200) {
            _listReport.data = null;
            ReportMonitorModel tempList =
                ReportMonitorModel.fromJson(response.data);
            if (_listReport.data == null || _listReport.data.length == 0) {
              _listReport = tempList;
              if (_listReport.data == null || _listReport.data.length == 0) {
                yield GetListReportEmpty();
              } else {
                yield GetListReportSuccess(_listReport);
              }
            } else {
              _listReport.data.addAll(tempList.data);
              yield GetListReportSuccess(_listReport);
            }
          } else {
            yield GetListReportFailed("Failed get data report");
          }
        }
      } catch (e) {
        yield GetListReportFailed(e.toString());
      }
    }
  }
}
