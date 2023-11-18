import 'package:bloc/bloc.dart';
import 'package:flutter_monisite/data/models/rfid_detection/rfid_master_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/api_service.dart';
import '../../../external/service/shared_preference_service.dart';

part 'rfid_event.dart';
part 'rfid_state.dart';

class RfidBloc extends Bloc<RfidEvent, RfidState> {
  ApiService _apiService = ApiService();
  SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  RFIDMasterModel _rfidMasterModel = RFIDMasterModel();
  RFIDMasterModel get rfidMasterModel => _rfidMasterModel;
  void setRfidMaster(List<DataRFIDMaster> data) {
    _rfidMasterModel.data?.addAll(data);
  }

  String _token = "";
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  RfidBloc() : super(RfidInitial()) {
    on<RfidEvent>((event, emit) async {
      if (event is GetRfidMaster) {
        emit(GetRfidMasterLoading());
        try {
          var tokenNew = await _sharedPreferenceService.getToken();
          if (tokenNew == null) {
            emit(SiteMustLogin());
          } else {
            _token = tokenNew;

            var response =
                await _apiService.getRfidMaster(event.siteId, _token);
            if (response?.statusCode == 200) {
              RFIDMasterModel tempList =
                  RFIDMasterModel.fromJson(response?.data);
              if (tempList.data?.length == 0) {
                emit(GetRfidMasterEmpty());
              } else {
                _rfidMasterModel = tempList;
                emit(GetRfidMasterSuccess(_rfidMasterModel));
              }
            } else {
              emit(GetRfidMasterFailed("Failed get data report"));
            }
          }
        } catch (e) {
          emit(GetRfidMasterFailed(e.toString()));
        }
      }
    });
  }
}
