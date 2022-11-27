
import 'package:bloc/bloc.dart';
import 'package:flutter_monisite/data/models/notification/notification_model.dart';
import 'package:flutter_monisite/data/repository/api_service.dart';
import 'package:flutter_monisite/external/service/shared_preference_service.dart';
import 'package:meta/meta.dart';

part 'notif_event.dart';
part 'notif_state.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  SharedPreferenceService _sharedPref = SharedPreferenceService();
  ApiService _apiService = ApiService();

  NotificationModel _notifModel = NotificationModel();
  NotificationModel get notifModel => _notifModel;
  void setNotifModel(NotificationModel notifModel) {
    _notifModel = notifModel;
  }

  String _token = "";
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  NotifBloc() : super(NotifInitial()) {
    on<GetListNotif>((event, emit) async {
      emit(GetListNotifLoading());
      try {
        var tokenNew = await _sharedPref.getToken();
        if (tokenNew == null) {
          emit(NotifMustLogin());
        } else {
          _token = tokenNew;

          var response = await _apiService.getListNotification(_token);
          if (response?.statusCode == 200) {
            _notifModel = NotificationModel.fromJson(response?.data);
            _notifModel.data = _notifModel.data!.reversed.toList();
            if (_notifModel.success!) {
              emit(GetListNotifSuccess(_notifModel));
            } else {
              emit(GetListNotifEmpty());
            }
          } else {
            emit(GetListNotifFailed("Failed get data monitor"));
          }
        }
      } catch (e) {
        emit(GetListNotifFailed(e.toString()));
      }
    });
    on<PostAcceptNotif>((event, emit) async {
      emit(PostAcceptNotifLoading());
      try {
        var tokenNew = await _sharedPref.getToken();
        if (tokenNew == null) {
          emit(NotifMustLogin());
        } else {
          _token = tokenNew;

          var response =
              await _apiService.postAcceptNotif(event.notifId, _token);
          if (response?.statusCode == 200) {
            emit(PostAcceptNotifSuccess());
          } else {
            emit(PostAcceptNotifFailed("Failed post fixing notif"));
          }
        }
      } catch (e) {
        emit(PostAcceptNotifFailed(e.toString()));
      }
    });
    on<PostHistoryProcess>((event, emit) async {
      emit(PostHistoryProcessLoading());
      try {
        var tokenNew = await _sharedPref.getToken();
        if (tokenNew == null) {
          emit(NotifMustLogin());
        } else {
          _token = tokenNew;

          var response = await _apiService.postHistoryProcess(
              event.notifId, event.status, _token);
          if (response?.statusCode == 200) {
            emit(PostHistoryProcessSuccess(event.status));
          } else {
            emit(PostHistoryProcessFailed("Failed post fixing notif"));
          }
        }
      } catch (e) {
        emit(PostHistoryProcessFailed(e.toString()));
      }
    });
  }
}
