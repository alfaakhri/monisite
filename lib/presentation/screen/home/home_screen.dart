import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/site/list_sites_model.dart';
import 'package:flutter_monisite/domain/bloc/site_bloc/site_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/screen/home/search_site_screen.dart';
import 'package:flutter_monisite/presentation/screen/login/login_screen.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'detail_site_monitor_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = "Stabil";
  

  late SiteBloc siteBloc;

  @override
  void initState() {
    // Provider.of<AuthProvider>(context, listen: false).getToken();
    siteBloc = BlocProvider.of<SiteBloc>(context);
    siteBloc.add(GetSites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: BlocConsumer<SiteBloc, SiteState>(
            listener: (context, state) {
              if (state is GetSitesFailed) {
                Fluttertoast.showToast(msg: state.message);
              } else if (state is SiteMustLogin) {
                Fluttertoast.showToast(msg: "Perlu login terlebih dahulu");
                Get.offAll(LoginScreen());
              }
            },
            builder: (context, state) {
              if (state is GetSitesLoading) {
                return _skeletonLoading();
              } else if (state is GetSitesSuccess) {
                return _buildListView(state.listSite);
              } else if (state is GetSitesFailed) {
                return ErrorHandlingWidget(
                    icon: "images/laptop.png",
                    title: state.message,
                    subTitle: "Silahkan kembali dalam beberapa saat lagi.");
              } else if (state is GetSitesEmpty) {
                return ErrorHandlingWidget(
                    icon: "images/laptop.png",
                    title: "Data site kosong",
                    subTitle: "Silahkan kembali dalam beberapa saat lagi.");
              }
              return _skeletonLoading();
            },
          )),
    );
  }

  Widget _buildListView(ListSitesModel sites) {
    return Column(
      children: <Widget>[
        TextFormField(
          showCursor: true,
          readOnly: true,
          onTap: () {
            Get.to(SearchSiteScreen());
          },
          decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorHelpers.colorGreyTextDark),
                  borderRadius: BorderRadius.circular(25)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorHelpers.colorGreyTextDark),
                  borderRadius: BorderRadius.circular(25)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorHelpers.colorGreyTextDark),
                  borderRadius: BorderRadius.circular(25)),
              hintText: "Cari cluster...",
              border: InputBorder.none),
        ),
        UIHelper.verticalSpaceMedium,
        Expanded(
          child: Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
              itemBuilder: (context, index) {
                var site = sites.data![index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(DetailSiteMonitorScreen(siteID: site.id ?? 0));
                    },
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
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.cloud,
                                        color: Colors.blue, size: 22),
                                    UIHelper.horizontalSpaceVerySmall,
                                    Text("Tenant OM: ${site.tenantOm ?? "-"}"),
                                  ],
                                ),
                                UIHelper.verticalSpaceVerySmall,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.place,
                                      color: Colors.blue,
                                      size: 22,
                                    ),
                                    UIHelper.horizontalSpaceVerySmall,
                                    Expanded(
                                        child: Text(
                                      site.address ?? "-",
                                      maxLines: 2,
                                    )),
                                  ],
                                ),
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
