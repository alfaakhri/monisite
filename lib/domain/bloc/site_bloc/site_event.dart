part of 'site_bloc.dart';

@immutable
abstract class SiteEvent {}

class GetSites extends SiteEvent {
  final String token;

  GetSites(this.token);
}

class GetSiteByID extends SiteEvent {
  final String siteId;
  final String token;

  GetSiteByID(this.siteId, this.token);

  
}