import 'package:flutter/material.dart';
import 'package:flutter_monisite/data/models/Site.dart';
import 'package:flutter_monisite/domain/provider/site_provider.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:provider/provider.dart';

import '../sample_pull_refresh.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  final String userId;

  const HomeScreen({Key key, this.userId})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = "Stabil";
  // ApiService apiService;

  // @override
  // void initState() {
  //   super.initState();
  //   apiService = ApiService();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
      Provider.of<SiteProvider>(context, listen: false).doFetchSiteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: Colors.grey),
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Cari cluster...", border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  Text("Bekasi"),
                ],
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, SiteProvider site, _) {
                  switch (site.state) {
                    case SiteState.loading:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case SiteState.loaded:
                      return _buildListView(site.sites);
                    case SiteState.unloaded:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Icon(
                                Icons.refresh,
                                size: 40,
                                color: ColorHelpers.colorBlue,
                              ),
                              onTap: () {
                                site.doFetchSiteList();
                              },
                            ),
                            UIHelper.verticalSpaceSmall,
                            Text(site.failure.message)
                          ],
                        ),
                      );

                    default:
                      Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<Site> sites) {
    return Padding(
      padding: EdgeInsets.zero,
      child: ListView.builder(
        itemBuilder: (context, index) {
          Site site = sites[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InkWell(
              onTap: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => SamplePulRefresh(
                    id: '${site.id}',
                  ),
                );
                Navigator.of(context).push(route);
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
                            site.sitename,
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text("Tenant OM: "),
                              Text(site.tenantom),
                            ],
                          ),
                          Text(site.address),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: sites.length,
      ),
    );
  }
}
