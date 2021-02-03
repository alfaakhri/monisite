part of 'list_report_bloc.dart';

@immutable
abstract class ListReportEvent {}

class GetListReport extends ListReportEvent {
  final int siteId;
  final String fromDate;
  final String toDate;
  final int pageIndex;

  GetListReport(this.siteId, this.fromDate, this.toDate, this.pageIndex);
}
