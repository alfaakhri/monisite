part of 'notif_bloc.dart';

@immutable
abstract class NotifEvent {}

class GetListNotif extends NotifEvent {}

class PostAcceptNotif extends NotifEvent {
  final int notifId;

  PostAcceptNotif(this.notifId);
}

class PostHistoryProcess extends NotifEvent {
  final int notifId;
  final int status;

  PostHistoryProcess(this.notifId, this.status);
}