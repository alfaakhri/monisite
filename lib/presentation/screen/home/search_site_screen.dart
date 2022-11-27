import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/site/list_sites_model.dart';
import 'package:flutter_monisite/domain/bloc/site_bloc/site_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/presentation/screen/login/login_screen.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SearchSiteScreen extends StatefulWidget {
  @override
  _SearchSiteScreenState createState() => _SearchSiteScreenState();
}

class _SearchSiteScreenState extends State<SearchSiteScreen> {
  late SiteBloc siteBloc;

  @override
  void initState() {
    siteBloc = BlocProvider.of<SiteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        siteBloc.add(GetSites());
        //trigger leaving and use own data
        Get.back();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  siteBloc.add(GetSites());
                  Get.back();
                }),
            title: TextFormField(
              onChanged: (value) {
                setState(() {
                  siteBloc.add(GetSiteBySearch(value));
                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: "Cari Cluster..."),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<SiteBloc, SiteState>(
              listener: (context, state) {
                if (state is GetSiteBySearchFailed) {
                  Fluttertoast.showToast(msg: state.message);
                } else if (state is SiteMustLogin) {
                  Fluttertoast.showToast(msg: "Perlu login terlebih dahulu");
                  Get.offAll(LoginScreen());
                }
              },
              builder: (context, state) {
                if (state is GetSiteBySearchLoading) {
                  return _skeletonLoading();
                } else if (state is GetSiteBySearchSuccess) {
                  return _buildListView(state.listSitesModel);
                } else if (state is GetSiteBySearchFailed) {
                  return ErrorHandlingWidget(
                      icon: "images/laptop.png",
                      title: "Gagal mengambil data",
                      subTitle: "Silahkan kembali dalam beberapa saat lagi.");
                } else if (state is GetSiteBySearchEmpty) {
                  return ErrorHandlingWidget(
                      icon: "images/laptop.png",
                      title: "Data site kosong",
                      subTitle: "Silahkan kembali dalam beberapa saat lagi.");
                }
                return Container();
              },
            ),
          )),
    );
  }

  Widget _buildListView(ListSitesModel sites) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
              itemBuilder: (context, index) {
                var site = sites.data![index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            // Container(
                            //   padding: EdgeInsets.all(3),
                            //   width: 100,
                            //   child: Text("Status: $status", textAlign: TextAlign.center,),
                            //   decoration: BoxDecoration(
                            //     color: (status == "Stabil") ? Colors.green : (status == "In Progress") ? Colors.yellow : Colors.red,
                            //     borderRadius: BorderRadius.circular(15),
                            //     border: Border.all(color: (status == "Stabil") ? Colors.green : (status == "In Progress") ? Colors.yellow : Colors.red),
                            //   ),
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  site.siteName ?? "-",
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("Tenant OM: "),
                                    Text(site.tenantOm ?? "-"),
                                  ],
                                ),
                                Text(site.address ?? "-"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: sites.data!.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _skeletonLoading() {
    return SkeletonAnimation(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                  color: ColorHelpers.colorGrey,
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
