part of 'rfid_bloc.dart';

@immutable
abstract class RfidEvent {}

class GetListRfidDetection extends RfidEvent {
  final int siteId;
  final int limit;

  GetListRfidDetection(this.siteId, this.limit);
}
