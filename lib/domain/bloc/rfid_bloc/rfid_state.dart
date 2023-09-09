part of 'rfid_bloc.dart';

@immutable
abstract class RfidState {}

class RfidInitial extends RfidState {}

class GetRfidDetectionLoading extends RfidState {}

class GetRfidDetectionSuccess extends RfidState {
  final RfidDetectionModel rfidDetectionModel;

  GetRfidDetectionSuccess(this.rfidDetectionModel);
}

class GetRfidDetectionEmpty extends RfidState {}

class GetRfidDetectionFailed extends RfidState {
  final String message;

  GetRfidDetectionFailed(this.message);
}

class SiteMustLogin extends RfidState {}
