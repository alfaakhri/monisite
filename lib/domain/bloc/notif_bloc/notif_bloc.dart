import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_monisite/data/models/notification/notification_model.dart';
import 'package:flutter_monisite/data/repository/api_service.dart';
import 'package:flutter_monisite/external/service/shared_preference_service.dart';
import 'package:meta/meta.dart';

part 'notif_event.dart';
part 'notif_state.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  NotifBloc() : super(NotifInitial());
  SharedPreferenceService _sharedPref = SharedPreferenceService();
  ApiService _apiService = ApiService();

  NotificationModel _notifModel = NotificationModel();
  NotificationModel get notifModel => _notifModel;
  void setNotifModel(NotificationModel notifModel) {
    _notifModel = notifModel;
  }

  String _token;
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  @override
  Stream<NotifState> mapEventToState(
    NotifEvent event,
  ) async* {
    if (event is GetListNotif) {
      yield GetListNotifLoading();
      try {
        var tokenNew = await _sharedPref.getToken();
        if (tokenNew == null) {
          yield NotifMustLogin();
        } else {
          _token = tokenNew;

          var response = await _apiService.getListNotification(_token);
          if (response.statusCode == 200) {
            _notifModel = NotificationModel.fromJson(response.data);
            if (_notifModel.success) {
              yield GetListNotifSuccess(_notifModel);
            } else {
              yield GetListNotifEmpty();
            }
          } else {
            yield GetListNotifFailed("Failed get data monitor");
          }
        }
      } catch (e) {
        yield GetListNotifFailed(e.toString());
      }
    }
  }
}
