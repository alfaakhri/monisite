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