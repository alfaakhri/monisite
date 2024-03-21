import 'package:flutter/material.dart';
import 'package:flutter_monisite/data/models/rfid_detection/detail_record_rfid_model.dart';
import 'package:flutter_monisite/data/models/rfid_detection/rfid_master_model.dart';

class RFIDProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => currentIndex;
  setCurrentIndex(int data) {
    _currentIndex = data;
  }

  List<DataRFIDMaster> _dataRFIDMaster = [];
  List<DataRFIDMaster> get dataRFIDMaster => _dataRFIDMaster;
  setListDataRFIDMaster(List<DataRFIDMaster> data) {
    _dataRFIDMaster = data;
  }

  List<RFIDRecordModel> _listRecordsRFID = [];
  List<RFIDRecordModel> get listRecordsRFID => _listRecordsRFID;
  setListRecordRFID(List<RFIDRecordModel> data) {
    _listRecordsRFID.clear();
    _listRecordsRFID = data;
  }

}
