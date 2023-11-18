part of 'detail_rfid_bloc.dart';

@immutable
abstract class DetailRfidEvent {}

class GetListRfidDetection extends DetailRfidEvent {
  final int siteId;
  final int id;

  GetListRfidDetection(this.siteId, this.id);
}

class GetRfidMaster extends DetailRfidEvent {
  final int siteId;

  GetRfidMaster(this.siteId);
}