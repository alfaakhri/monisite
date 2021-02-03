part of 'list_report_bloc.dart';

@immutable
abstract class ListReportState {}

class ListReportInitial extends ListReportState {}

class GetListReportLoading extends ListReportState {}

class GetListReportSuccess extends ListReportState {
  final ReportMonitorModel listReport;

  GetListReportSuccess(this.listReport);
}

class GetListReportEmpty extends ListReportState {}

class GetListReportFailed extends ListReportState {
  final String message;

  GetListReportFailed(this.message);
}

class SiteMustLogin extends ListReportState {}
