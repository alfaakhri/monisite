part of 'rfid_bloc.dart';

@immutable
abstract class RfidEvent {}

class GetRfidMaster extends RfidEvent {
  final int siteId;

  GetRfidMaster(this.siteId);
}