part of 'site_bloc.dart';

@immutable
abstract class SiteState {}

class SiteInitial extends SiteState {}

class GetSitesLoading extends SiteState {}

class GetSitesSuccess extends SiteState {
  final List<Site> listSite;

  GetSitesSuccess(this.listSite);
}

class GetSitesFailed extends SiteState {
  final String message;

  GetSitesFailed(this.message);
}

class GetSiteByIDLoading extends SiteState{}

class GetSiteByIDSuccess extends SiteState{
  final Site site;

  GetSiteByIDSuccess(this.site);
}

class GetSiteByIDFailed extends SiteState{
  final String message;

  GetSiteByIDFailed(this.message);
}

