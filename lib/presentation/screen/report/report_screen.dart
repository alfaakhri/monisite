import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/ChartReport.dart';
import 'package:flutter_monisite/data/models/monitor/report_monitor_model.dart';
import 'package:flutter_monisite/domain/bloc/site_bloc/site_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/date_picker.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:charts_flutter/flutter.dart' as charts;

List<String> listItem = [
  'Suhu',
  'Tekanan',
  'Arus R',
  'Arus S',
  'Arus T',
  'Arus AC',
  'Tegangan RS',
  'Tegangan RT',
  'Tegangan ST',
  'Tegangan RN',
  'Tegangan SN',
  'Tegangan TN'
];

class ReportScreen extends StatefulWidget {
  final int siteId;

  const ReportScreen({Key key, this.siteId}) : super(key: key);
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  SiteBloc siteBloc;
  String _itemFilter = "Suhu";
  TextEditingController _dateController = TextEditingController();

  List<charts.Series<ChartReport, DateTime>> _seriesLineData;

  @override
  void initState() {
    super.initState();
    siteBloc = BlocProvider.of<SiteBloc>(context);
    siteBloc.add(GetReportMonitor(widget.siteId,
        DateFormat("yyyy-MM-dd").format(DateTime.now().toLocal())));
    _seriesLineData = List<charts.Series<ChartReport, DateTime>>();
  }

  // void addFlSpot(ReportMonitorModel report) {
  //   // List<DataPoint<dynamic>> _data = List<DataPoint<dynamic>>();
  //   List<FlSpot> _data = List<FlSpot>();
  //   List<double> xAxis = List<double>();
  //   report.data.forEach((element) {
  //     String time = DateTime.parse(element.createdAt).toLocal().toString();
  //     print("Time $time");
  //     time = time.split(" ")[1];
  //     time = time.split(".")[0];
  //     time = time.substring(0, 5);
  //     time = time.replaceAll(":", ".");
  //     double timeNew = double.parse(time);
  //     print("Waktu : $time - $timeNew");

  //     // _data.add(DataPoint<double>(
  //     //     value: double.parse(element.temperature), xAxis: timeNew));
  //     _data.add(FlSpot(timeNew, double.parse(element.temperature)));
  //     xAxis.add(timeNew);
  //   });
  //   setState(() {
  //     dataReport = _data.reversed.toList();
  //     xAxisListReport = xAxis.reversed.toList();
  //   });
  // }

  _generateData(ReportMonitorModel report, String filter) {
    List<ChartReport> lineSalesdata = List<ChartReport>();
    report.data.map((element) {
      if (filter.toLowerCase() == "suhu") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.temperature)));
      } else if (filter.toLowerCase() == "tekanan") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.pressure)));
      } else if (filter.toLowerCase() == "arus r") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.arusR)));
      } else if (filter.toLowerCase() == "arus s") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.arusS)));
      } else if (filter.toLowerCase() == "arus t") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.arusT)));
      } else if (filter.toLowerCase() == "arus ac") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.arusAc)));
      } else if (filter.toLowerCase() == "tegangan rs") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.teganganRs)));
      } else if (filter.toLowerCase() == "tegangan st") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.teganganSt)));
      } else if (filter.toLowerCase() == "tegangan rn") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.teganganRn)));
      } else if (filter.toLowerCase() == "tegangan sn") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.teganganSn)));
      } else if (filter.toLowerCase() == "tegangan tn") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.teganganTn)));
      } else if (filter.toLowerCase() == "tegangan rt") {
        lineSalesdata.add(ChartReport(
            DateTime.parse(element.createdAt).toLocal(),
            double.parse(element.teganganRt)));
      }
    }).toList();

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blue),
        id: 'Air Pollution',
        data: lineSalesdata,
        domainFn: (ChartReport report, _) => report.time,
        measureFn: (ChartReport report, _) => report.data,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        siteBloc.add(GetSiteByID(widget.siteId));
        //trigger leaving and use own data
        Get.back();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Laporan"),
            leading: IconButton(
              onPressed: () {
                siteBloc.add(GetSiteByID(widget.siteId));
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: BlocConsumer<SiteBloc, SiteState>(
              cubit: siteBloc,
              listener: (context, state) {
                if (state is GetReportMonitorFailed) {
                  Fluttertoast.showToast(msg: state.message);
                } else if (state is GetReportMonitorSuccess) {
                  _seriesLineData.clear();

                  _generateData(state.reportMonitor, "Suhu");
                }
              },
              builder: (context, state) {
                if (state is GetReportMonitorSuccess) {
                  return _buildContent(state.reportMonitor);
                } else if (state is GetReportMonitorFailed) {
                  return ErrorHandlingWidget(
                    icon: 'images/laptop.png',
                    title: "Ada sesuatu yang error",
                    subTitle: "Silahkan kembali beberapa saat lagi.",
                  );
                } else if (state is GetReportMonitorLoading) {
                  return _buildSkeletonLoading();
                } else if (state is GetReportMonitorEmpty) {
                  return ErrorHandlingWidget(
                    icon: 'images/laptop.png',
                    title: "Data Laporan Kosong",
                    subTitle: "Silahkan kembali beberapa saat lagi.",
                  );
                }
                return _buildSkeletonLoading();
              })),
    );
  }

  Widget _buildSkeletonLoading() {
    return SkeletonAnimation(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 50,
                    color: ColorHelpers.colorGrey,
                  ),
                ),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 50,
                    color: ColorHelpers.colorGrey,
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpaceSmall,
          Container(
            color: ColorHelpers.colorGrey,
            width: MediaQuery.of(context).size.width,
            height: 250,
          ),
          UIHelper.verticalSpaceSmall,
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
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
          ),
        ]),
      ),
    );
  }

  Widget _buildContent(ReportMonitorModel reportMonitorModel) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: "Sensor",
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    items: listItem
                        .map((value) => DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        _itemFilter = value;
                        _seriesLineData.clear();
                        _generateData(reportMonitorModel, _itemFilter);
                      });
                    },
                    value: _itemFilter),
              ),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                flex: 5,
                child: TextFormField(
                  controller: _dateController,
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());

                    DatePicker().selectDate(context).then((result) {
                      setState(() {
                        if (result == null) {
                          _dateController.text = null;
                        } else {
                          _dateController.text =
                              DateFormat("yyyy-MM-dd").format(result);
                          siteBloc.add(GetReportMonitor(
                              widget.siteId, _dateController.text));
                        }
                      });
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelText: "Tanggal",
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
              ),
            ],
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(reportMonitorModel.data.first.siteName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: EdgeInsets.only(right: 16.0, left: 6.0),
            child: chart(reportMonitorModel),
          ),
        ),
        UIHelper.verticalSpaceMedium,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: reportMonitorModel.data.map((data) {
                return Card(
                  margin: EdgeInsets.only(top: 15),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: ColorHelpers.colorBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                (_itemFilter.toLowerCase() == "suhu")
                                    ? data.temperature
                                    : (_itemFilter.toLowerCase() == "tekanan")
                                        ? data.pressure
                                        : (_itemFilter.toLowerCase() ==
                                                "arus r")
                                            ? data.arusR
                                            : (_itemFilter.toLowerCase() ==
                                                    "arus s")
                                                ? data.arusS
                                                : (_itemFilter.toLowerCase() ==
                                                        "arus t")
                                                    ? data.arusT
                                                    : (_itemFilter
                                                                .toLowerCase() ==
                                                            "arus ac")
                                                        ? data.arusAc
                                                        : (_itemFilter
                                                                    .toLowerCase() ==
                                                                "tegangan rs")
                                                            ? data.teganganRs
                                                            : (_itemFilter
                                                                        .toLowerCase() ==
                                                                    "tegangan rt")
                                                                ? data
                                                                    .teganganRt
                                                                : (_itemFilter
                                                                            .toLowerCase() ==
                                                                        "tegangan st")
                                                                    ? data
                                                                        .teganganSt
                                                                    : (_itemFilter.toLowerCase() ==
                                                                            "tegangan rn")
                                                                        ? data
                                                                            .teganganRn
                                                                        : (_itemFilter.toLowerCase() ==
                                                                                "tegangan sn")
                                                                            ? data
                                                                                .teganganSn
                                                                            : data
                                                                                .teganganTn,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500)),
                            UIHelper.horizontalSpaceVerySmall,
                            Text(
                                (_itemFilter.toLowerCase() == "suhu")
                                    ? "Celcius"
                                    : (_itemFilter.toLowerCase() == "tekanan")
                                        ? "Psi"
                                        : (_itemFilter.toLowerCase() ==
                                                    "arus r" ||
                                                _itemFilter.toLowerCase() ==
                                                    "arus s" ||
                                                _itemFilter.toLowerCase() ==
                                                    "arus t" ||
                                                _itemFilter.toLowerCase() ==
                                                    "arus ac")
                                            ? "Ampere"
                                            : (_itemFilter.toLowerCase() ==
                                                        "tegangan rs" ||
                                                    _itemFilter.toLowerCase() ==
                                                        "tegangan rt" ||
                                                    _itemFilter.toLowerCase() ==
                                                        "tegangan st" ||
                                                    _itemFilter.toLowerCase() ==
                                                        "tegangan rn" ||
                                                    _itemFilter.toLowerCase() ==
                                                        "tegangan sn")
                                                ? "Volt"
                                                : "-",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.blue,
                              size: 22,
                            ),
                            UIHelper.horizontalSpaceVerySmall,
                            Text(
                                DateFormat("HH:mm").format(
                                    DateTime.parse(data.createdAt).toLocal()),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6))),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }

  Widget chart(ReportMonitorModel report) {
    return charts.TimeSeriesChart(_seriesLineData,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: true,
        animationDuration: Duration(seconds: 5),
        behaviors: [
          new charts.ChartTitle('Hari',
              behaviorPosition: charts.BehaviorPosition.bottom,
              titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea),
          new charts.ChartTitle(_itemFilter,
              behaviorPosition: charts.BehaviorPosition.start,
              titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea),
        ]);
  }
}
