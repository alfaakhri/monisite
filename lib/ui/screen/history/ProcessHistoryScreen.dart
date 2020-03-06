import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_monisite/core/models/Site.dart';
import 'package:flutter_monisite/core/service/ApiService.dart';

class ProcessHistoryScreen extends StatefulWidget {
  @override
  _ProcessHistoryScreenState createState() => _ProcessHistoryScreenState();
}

class _ProcessHistoryScreenState extends State<ProcessHistoryScreen> {
  List<Site> listSite;
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.getSites(),
      builder: (BuildContext context, AsyncSnapshot<List<Site>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<Site> sites = snapshot.data;
          return _buildListView(sites);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildListView(List<Site> sites) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Site site = sites[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: InkWell(
            onTap: () {},
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  site.sitename,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Tenant OM: "),
                                  Text(site.tenantom),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  width: 200, child: Text(site.address)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Yang perlu ditinjau: '),
                                  Text(
                                    'High Temperature',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Pekerja: '),
                                  Text(
                                    'Tim On Site',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text('02.00',
                                      style: TextStyle(
                                          fontSize: 32, color: Colors.green)),
                                ),
                                Container(
                                  child: Text('Sisa'),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: sites.length,
    );
  }
}
