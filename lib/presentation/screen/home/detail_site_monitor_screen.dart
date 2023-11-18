import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/monitor/monitor_model.dart';
import 'package:flutter_monisite/domain/bloc/site_bloc/site_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/presentation/screen/home/widgets/detail_site_monitor_shimmer.dart';
import 'package:flutter_monisite/presentation/screen/home/widgets/header_detail_monitor_widget.dart';
import 'package:flutter_monisite/presentation/screen/home/widgets/list_data_unit_widget.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class DetailSiteMonitorScreen extends StatefulWidget {
  final int siteID;

  const DetailSiteMonitorScreen({Key? key, required this.siteID})
      : super(key: key);
  @override
  _DetailSiteMonitorScreenState createState() =>
      _DetailSiteMonitorScreenState();
}

class _DetailSiteMonitorScreenState extends State<DetailSiteMonitorScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late SiteBloc siteBloc;

  @override
  void initState() {
    super.initState();
    siteBloc = BlocProvider.of<SiteBloc>(context);
    siteBloc.add(GetSiteByID(widget.siteID));
  }

  Widget buildCtn() {
    return BlocConsumer<SiteBloc, SiteState>(
      listener: (context, state) {
        if (state is GetSiteByIDFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state) {
        if (state is GetSiteByIDLoading) {
          return DetailSiteMonitorShimmer();
        } else if (state is GetSiteByIDSuccess) {
          return _buildDetailHomeScreen(state.dataMonitor, siteBloc.status);
        } else if (state is GetSiteByIDEmpty) {
          return ErrorHandlingWidget(
              icon: "images/laptop.png",
              title: state.message,
              subTitle: "Silahkan kembali dalam beberapa saat lagi.");
        } else if (state is GetSiteByIDFailed) {
          return ErrorHandlingWidget(
              icon: "images/laptop.png",
              title: state.message,
              subTitle: "Silahkan kembali dalam beberapa saat lagi.");
        }
        return DetailSiteMonitorShimmer();
      },
    );
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
        backgroundColor: ColorHelpers.colorBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              siteBloc.add(GetSites());
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullUp: false,
            child: buildCtn(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              completeDuration: Duration(milliseconds: 500),
            ),
            header: WaterDropMaterialHeader(
                backgroundColor: Colors.white.withOpacity(0.8),
                color: Colors.blue),
            onRefresh: () async {
              //monitor fetch data from network
              await Future.delayed(Duration(milliseconds: 1000));

              siteBloc.add(GetSiteByID(widget.siteID));

              if (mounted) setState(() {});
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              //monitor fetch data from network
              await Future.delayed(Duration(milliseconds: 1000));
//        for (int i = 0; i < 10; i++) {
//          data.add("Item $i");
//        }
              if (mounted) setState(() {});
              _refreshController.loadFailed();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailHomeScreen(MonitorModel monitor, String status) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderDetailMonitorWidget(status: status, monitor: monitor),
            ListDataUnitWidget(monitor: monitor),
          ],
        ),
      ),
    );
  }
}
