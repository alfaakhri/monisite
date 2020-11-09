import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_monisite/data/models/Site.dart';
import 'package:flutter_monisite/data/repository/api_service.dart';
import 'package:meta/meta.dart';

part 'site_event.dart';
part 'site_state.dart';

class SiteBloc extends Bloc<SiteEvent, SiteState> {
  SiteBloc() : super(SiteInitial());
  ApiService _apiService = ApiService();

  List<Site> _listSites = List<Site>();
  List<Site> get listSites => _listSites;
  void setListSites(List<Site> listSites) {
    _listSites = listSites;
  }

  Site _dataSite = Site();
  Site get dataSite => _dataSite;
  void setDataSite(Site dataSite) {
    _dataSite = dataSite;
  }



  @override
  Stream<SiteState> mapEventToState(
    SiteEvent event,
  ) async* {
    if (event is GetSites) {
      yield GetSitesLoading();
      try {
        var response = await _apiService.getSitesNew(event.token);
        if (response.statusCode == 200) {
          _listSites = siteFromJson(response.data);
          yield GetSitesSuccess(_listSites);
        } else {
          yield GetSitesFailed("Failed get data sites");
        }
      } catch (e) {
        yield GetSitesFailed(e.toString());
      }
    } else if (event is GetSiteByID) {
      yield GetSiteByIDLoading();
      try {
        var response = await _apiService.getSiteById(event.siteId,event.token);
        if (response.statusCode == 200) {
          _dataSite = Site.fromJson(response.data);
          yield GetSiteByIDSuccess(_dataSite);
        } else {
          yield GetSiteByIDFailed("Failed get data sites");
        }
      } catch (e) {
        yield GetSiteByIDFailed(e.toString());
      }
    }
  }
}
