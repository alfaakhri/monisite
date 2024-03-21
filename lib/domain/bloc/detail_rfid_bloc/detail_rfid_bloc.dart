import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/rfid_detection/detail_record_rfid_model.dart';
import '../../../data/repository/api_service.dart';
import '../../../external/service/shared_preference_service.dart';

part 'detail_rfid_event.dart';
part 'detail_rfid_state.dart';

class DetailRfidBloc extends Bloc<DetailRfidEvent, DetailRfidState> {
  ApiService _apiService = ApiService();
  SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  List<RFIDRecordModel> _rfidModel = [];
  List<RFIDRecordModel> get rfidModel => _rfidModel;
  void setDetailRecord(List<RFIDRecordModel> data) {
    _rfidModel.addAll(data);
  }

  String _token = "";
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  DetailRfidBloc() : super(DetailRfidInitial()) {
    on<DetailRfidEvent>((event, emit) async {
      if (event is GetListRfidDetection) {
        emit(GetRfidDetectionLoading());
        try {
          var tokenNew = await _sharedPreferenceService.getToken();
          if (tokenNew == null) {
            emit(SiteMustLogin());
          } else {
            _token = tokenNew;

            var response = await _apiService.getRfidDetection(
                event.siteId, _token, event.code);

            if (response?.statusCode == 200) {

              List<RFIDRecordModel>? rfidList = List.from(
              (response?.data as List).map((e) => RFIDRecordModel.fromJson(e)));

              if (rfidList.length == 0) {
                emit(GetRfidDetectionEmpty());
              } else {
                _rfidModel = rfidList;
                emit(GetRfidDetectionSuccess(rfidList));
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
