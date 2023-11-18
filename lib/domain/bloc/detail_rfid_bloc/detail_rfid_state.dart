part of 'detail_rfid_bloc.dart';

@immutable
abstract class DetailRfidState {}

class DetailRfidInitial extends DetailRfidState {}

class GetRfidDetectionLoading extends DetailRfidState {}

class GetRfidDetectionSuccess extends DetailRfidState {
  final DetailRecordRFIDModel rfidDetectionModel;

  GetRfidDetectionSuccess(this.rfidDetectionModel);
}

class GetRfidDetectionEmpty extends DetailRfidState {}

class GetRfidDetectionFailed extends DetailRfidState {
  final String message;

  GetRfidDetectionFailed(this.message);
}

class SiteMustLogin extends DetailRfidState {}
