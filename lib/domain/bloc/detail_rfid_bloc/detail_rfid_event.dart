part of 'detail_rfid_bloc.dart';

@immutable
abstract class DetailRfidEvent {}

class GetListRfidDetection extends DetailRfidEvent {
  final int siteId;
  final String code;

  GetListRfidDetection(this.siteId, this.code);
}

class GetRfidMaster extends DetailRfidEvent {
  final int siteId;

  GetRfidMaster(this.siteId);
}