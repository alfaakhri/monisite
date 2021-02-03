part of 'notif_bloc.dart';

@immutable
abstract class NotifState {}

class NotifInitial extends NotifState {}

class GetListNotifLoading extends NotifState {}

class GetListNotifEmpty extends NotifState {}

class GetListNotifSuccess extends NotifState {
  final NotificationModel notificationModel;

  GetListNotifSuccess(this.notificationModel);
}

class GetListNotifFailed extends NotifState {
  final String message;

  GetListNotifFailed(this.message);
}

class NotifMustLogin extends NotifState {}

class PostAcceptNotifLoading extends NotifState {}

class PostAcceptNotifSuccess extends NotifState {}

class PostAcceptNotifFailed extends NotifState {
  final String message;

  PostAcceptNotifFailed(this.message);
}

class PostHistoryProcessLoading extends NotifState {}

class PostHistoryProcessSuccess extends NotifState {
  final int status;

  PostHistoryProcessSuccess(this.status);
}

class PostHistoryProcessFailed extends NotifState {
  final String message;
  PostHistoryProcessFailed(this.message);
}
