part of 'rfid_bloc.dart';

@immutable
abstract class RfidState {}

class RfidInitial extends RfidState {}

class GetRfidMasterEmpty extends RfidState {}

class GetRfidMasterLoading extends RfidState {}

class GetRfidMasterSuccess extends RfidState {
  final RFIDMasterModel rfidMasterModel;

  GetRfidMasterSuccess(this.rfidMasterModel);
}

class GetRfidMasterFailed extends RfidState {
  final String message;

  GetRfidMasterFailed(this.message);
}

class SiteMustLogin extends RfidState {}
