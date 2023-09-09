import 'package:bloc/bloc.dart';
import 'package:flutter_monisite/data/models/rfid_detection/rfid_detection_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/api_service.dart';
import '../../../external/service/shared_preference_service.dart';

part 'rfid_event.dart';
part 'rfid_state.dart';

class RfidBloc extends Bloc<RfidEvent, RfidState> {
  ApiService _apiService = ApiService();
  SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  RfidDetectionModel _rfidModel = RfidDetectionModel();
  RfidDetectionModel get rfidModel => _rfidModel;
  void setFaceDetection(List<DataRfid> data) {
    _rfidModel.data?.addAll(data);
  }

  String _token = "";
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  RfidBloc() : super(RfidInitial()) {
    on<RfidEvent>((event, emit) async {
      if (event is GetListRfidDetection) {
        emit(GetRfidDetectionLoading());
        try {
          var tokenNew = await _sharedPreferenceService.getToken();
          if (tokenNew == null) {
            emit(SiteMustLogin());
          } else {
            _token = tokenNew;

            var response =
                await _apiService.getFaceDetection(event.siteId, _token, 30);
            if (response?.statusCode == 200) {
              RfidDetectionModel tempList =
                  RfidDetectionModel.fromJson(response?.data);
              if (tempList.data?.length == 0) {
                emit(GetRfidDetectionEmpty());
              } else {
                _rfidModel = tempList;
                emit(GetRfidDetectionSuccess(_rfidModel));
              }
            } else {
              emit(GetRfidDetectionFailed("Failed get data report"));
            }
          }
        } catch (e) {
          emit(GetRfidDetectionFailed(e.toString()));
        }
      }
    });
  }
}
