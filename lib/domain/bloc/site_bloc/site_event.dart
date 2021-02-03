part of 'site_bloc.dart';

@immutable
abstract class SiteEvent {}

class GetSites extends SiteEvent {}

class GetSiteByID extends SiteEvent {
  final int siteId;

  GetSiteByID(this.siteId);
}

class GetSiteBySearch extends SiteEvent {
  final String result;

  GetSiteBySearch(this.result);
}

class GetReportMonitor extends SiteEvent {
  final int siteId;
  final String fromDate;
  final String toDate;

  GetReportMonitor(this.siteId, this.fromDate, this.toDate);
}
