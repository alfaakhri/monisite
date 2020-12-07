part of 'site_bloc.dart';

@immutable
abstract class SiteState {}

class SiteInitial extends SiteState {}

class GetSitesLoading extends SiteState {}

class GetSitesEmpty extends SiteState {}

class GetSitesSuccess extends SiteState {
  final ListSitesModel listSite;

  GetSitesSuccess(this.listSite);
}

class GetSitesFailed extends SiteState {
  final String message;

  GetSitesFailed(this.message);
}

class GetSiteByIDLoading extends SiteState {}

class GetSiteByIDSuccess extends SiteState {
  final MonitorModel dataMonitor;

  GetSiteByIDSuccess(this.dataMonitor);
}

class GetSiteByIDFailed extends SiteState {
  final String message;

  GetSiteByIDFailed(this.message);
}

class GetSiteByIDEmpty extends SiteState {
  final String message;

  GetSiteByIDEmpty(this.message);
}

class GetSiteBySearchLoading extends SiteState {}

class GetSiteBySearchFailed extends SiteState {
  final String message;
  GetSiteBySearchFailed(this.message);
}

class GetSiteBySearchEmpty extends SiteState {}

class GetSiteBySearchSuccess extends SiteState {
  final ListSitesModel listSitesModel;

  GetSiteBySearchSuccess(this.listSitesModel);
}

class GetReportMonitorLoading extends SiteState {}
class GetReportMonitorSuccess extends SiteState {
  final ReportMonitorModel reportMonitor;

  GetReportMonitorSuccess(this.reportMonitor);
}
class GetReportMonitorFailed extends SiteState {
  final String message;

  GetReportMonitorFailed(this.message);
}
class GetReportMonitorEmpty extends SiteState {}

class GetListReportLoading extends SiteState {}

class GetListReportSuccess extends SiteState {}

class GetListReportEmpty extends SiteState {}

class GetListReportFailed extends SiteState {
  final String message;

  GetListReportFailed(this.message);
}

class SiteMustLogin extends SiteState {}
