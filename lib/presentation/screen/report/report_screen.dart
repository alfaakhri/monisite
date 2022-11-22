// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_monisite/data/models/ChartReport.dart';
// import 'package:flutter_monisite/data/models/monitor/report_monitor_model.dart';
// import 'package:flutter_monisite/data/repository/api_service.dart';
// import 'package:flutter_monisite/domain/bloc/list_report_bloc/list_report_bloc.dart';
// import 'package:flutter_monisite/domain/bloc/site_bloc/site_bloc.dart';
// import 'package:flutter_monisite/external/color_helpers.dart';
// import 'package:flutter_monisite/external/date_picker.dart';
// import 'package:flutter_monisite/external/ui_helpers.dart';
// import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:skeleton_text/skeleton_text.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// List<String> listItem = [
//   'Suhu',
//   'Tekanan',
//   'Arus R',
//   'Arus S',
//   'Arus T',
//   'Arus AC',
//   'Tegangan RS',
//   'Tegangan RT',
//   'Tegangan ST',
//   'Tegangan RN',
//   'Tegangan SN',
//   'Tegangan TN'
// ];

// class ReportScreen extends StatefulWidget {
//   final int siteId;

//   const ReportScreen({Key key, this.siteId}) : super(key: key);
//   @override
//   _ReportScreenState createState() => _ReportScreenState();
// }

// class _ReportScreenState extends State<ReportScreen> {
//   SiteBloc siteBloc;
//   ListReportBloc listReportBloc;
//   String _itemFilter;
//   TextEditingController _fromDate = TextEditingController();
//   TextEditingController _toDate = TextEditingController();
//   ScrollController _scrollController = new ScrollController();
//   int _pageIndex = 2;
//   List<charts.Series<ChartReport, DateTime>> _seriesLineData;
//   bool isLoading = false;
//   Widget lineChart;

//   DateTime dateFrom;
//   DateTime dateTo;

//   @override
//   void initState() {
//     super.initState();
//     siteBloc = BlocProvider.of<SiteBloc>(context);
//     listReportBloc = BlocProvider.of<ListReportBloc>(context);
//     dateFrom = DateTime.now().toLocal();
//     dateTo = DateTime(dateFrom.year, dateFrom.month, dateFrom.day + 1);
//     this._itemFilter = "Suhu";
//     _fromDate.text = DateFormat("dd MMM yyyy").format(dateFrom);
//     _toDate.text = DateFormat("dd MMM yyyy").format(dateTo);
//     siteBloc.add(GetReportMonitor(
//         widget.siteId, dateFrom.toString(), dateTo.toString()));
//     _seriesLineData = List<charts.Series<ChartReport, DateTime>>();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         // siteBloc.add(
//         //     GetListReport(widget.siteId, _dateController.text, _pageIndex++));
//         _getMoreData();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         siteBloc.add(GetSiteByID(widget.siteId));

//         //trigger leaving and use own data
//         Get.back();
//         //we need to return a future
//         return Future.value(false);
//       },
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             title: Text("Laporan"),
//             leading: IconButton(
//               onPressed: () {
//                 siteBloc.add(GetSiteByID(widget.siteId));
//                 Get.back();
//               },
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           body: BlocConsumer<SiteBloc, SiteState>(
//               cubit: siteBloc,
//               listener: (context, state) {
//                 if (state is GetReportMonitorFailed) {
//                   Fluttertoast.showToast(msg: state.message);
//                 } else if (state is GetReportMonitorSuccess) {
//                   _seriesLineData.clear();
//                   _generateData(state.reportMonitor, "Suhu");
//                   listReportBloc.add(GetListReport(
//                       widget.siteId,
//                       DateFormat("yyyy-MM-dd").format(this.dateFrom),
//                       DateFormat("yyyy-MM-dd").format(this.dateTo),
//                       1));
//                 }
//               },
//               builder: (context, state) {
//                 if (state is GetReportMonitorSuccess) {
//                   return _buildContent(state.reportMonitor);
//                 } else if (state is GetReportMonitorFailed) {
//                   return ErrorHandlingWidget(
//                     icon: 'images/laptop.png',
//                     title: "Gagal mengambil data",
//                     subTitle: "Silahkan kembali beberapa saat lagi.",
//                   );
//                 } else if (state is GetReportMonitorLoading) {
//                   return _buildSkeletonLoading();
//                 } else if (state is GetReportMonitorEmpty) {
//                   return _buildErrorHandling(context);
//                 }
//                 return _buildContent(siteBloc.reportMonitor);
//               })),
//     );
//   }

//   ListView _buildErrorHandling(BuildContext context) {
//     return ListView(
//       children: [
//         _contentFilter(),
//         Center(
//           heightFactor: 3.5,
//           child: ErrorHandlingWidget(
//             icon: 'images/laptop.png',
//             title: "Laporan Hari Ini Belum Ada",
//             subTitle: "Silahkan filter tanggal terlebih dahulu",
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSkeletonLoading() {
//     return SkeletonAnimation(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(children: [
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   flex: 5,
//                   child: Container(
//                     height: 50,
//                     color: ColorHelpers.colorGrey,
//                   ),
//                 ),
//                 UIHelper.horizontalSpaceSmall,
//                 Expanded(
//                   flex: 5,
//                   child: Container(
//                     height: 50,
//                     color: ColorHelpers.colorGrey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           UIHelper.verticalSpaceSmall,
//           Container(
//             color: ColorHelpers.colorGrey,
//             width: MediaQuery.of(context).size.width,
//             height: 350,
//           ),
//           UIHelper.verticalSpaceSmall,
//           Expanded(
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 80,
//                     decoration: BoxDecoration(
//                         color: ColorHelpers.colorGrey,
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 );
//               },
//               itemCount: 10,
//             ),
//           ),
//         ]),
//       ),
//     );
//   }

//   Widget _buildSkeletonOneDataListLoading() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }

//   Widget _buildContent(ReportMonitorModel reportMonitorModel) {
//     if (reportMonitorModel == null) {
//       return _buildSkeletonLoading();
//     } else {
//       if (reportMonitorModel.data == null ||
//           reportMonitorModel.data.length == 0) {
//         return _buildErrorHandling(context);
//       } else {
//         return ListView(
//           controller: _scrollController,
//           children: [
//             _contentFilter(reportMonitorModel: reportMonitorModel),
//             UIHelper.verticalSpaceSmall,
//             Text(reportMonitorModel.data.first.siteName,
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center),
//             Container(
//               height: 350,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(color: Colors.white),
//               child: Padding(
//                 padding: EdgeInsets.only(right: 16.0, left: 6.0),
//                 child: lineChart,
//               ),
//             ),
//             UIHelper.verticalSpaceMedium,
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: BlocBuilder<ListReportBloc, ListReportState>(
//                 builder: (context, state) {
//                   if (state is GetListReportLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state is GetListReportEmpty) {
//                     return ErrorHandlingWidget(
//                       icon: 'images/laptop.png',
//                       title: "Daftar Laporan Hari Ini Belum Ada",
//                       subTitle: "Silahkan kembali beberapa saat lagi.",
//                     );
//                   } else if (state is GetListReportFailed) {
//                     return ErrorHandlingWidget(
//                       icon: 'images/laptop.png',
//                       title: "Gagal mengambil data",
//                       subTitle: "Silahkan kembali beberapa saat lagi.",
//                     );
//                   } else if (state is GetListReportSuccess) {
//                     return buildContentListReport(state.listReport);
//                   }
//                   return Center(child: CircularProgressIndicator());
//                 },
//               ),
//             ),
//           ],
//         );
//       }
//     }
//   }

//   Container _contentFilter({ReportMonitorModel reportMonitorModel}) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Column(
//         children: [
//           DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10),
//                   labelText: "Sensor",
//                   filled: true,
//                   fillColor: Colors.white,
//                   isDense: true,
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blue)),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black)),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black))),
//               items: listItem
//                   .map((value) => DropdownMenuItem<String>(
//                         child: Text(value),
//                         value: value,
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _itemFilter = value;
//                   _seriesLineData.clear();

//                   _generateData(reportMonitorModel, _itemFilter);
//                 });
//               },
//               value: _itemFilter),
//           UIHelper.verticalSpaceSmall,
//           Row(
//             children: [
//               Expanded(
//                 flex: 5,
//                 child: TextFormField(
//                   controller: _fromDate,
//                   onTap: () {
//                     FocusScope.of(context).requestFocus(new FocusNode());

//                     DatePicker().selectDate(context).then((result) {
//                       setState(() {
//                         if (result == null) {
//                           _fromDate.text = null;
//                         } else {
//                           _pageIndex = 2;
//                           this.dateFrom = result;
//                           siteBloc.add(GetReportMonitor(widget.siteId,
//                               result.toString(), this.dateTo.toString()));
//                           _fromDate.text =
//                               DateFormat("dd MMM yyyy").format(result);
//                         }
//                       });
//                     });
//                   },
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10),
//                       labelText: "Tanggal Mulai",
//                       filled: true,
//                       fillColor: Colors.white,
//                       isDense: true,
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.black)),
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.black))),
//                 ),
//               ),
//               UIHelper.horizontalSpaceSmall,
//               Expanded(
//                 flex: 5,
//                 child: TextFormField(
//                   controller: _toDate,
//                   onTap: () {
//                     FocusScope.of(context).requestFocus(new FocusNode());

//                     DatePicker().selectDate(context).then((result) {
//                       setState(() {
//                         if (result == null) {
//                           _toDate.text = null;
//                         } else {
//                           _pageIndex = 2;
//                           this.dateTo = result;
//                           siteBloc.add(GetReportMonitor(widget.siteId,
//                               this.dateFrom.toString(), result.toString()));

//                           _toDate.text =
//                               DateFormat("dd MMM yyyy").format(result);
//                         }
//                       });
//                     });
//                   },
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10),
//                       labelText: "Tanggal Akhir",
//                       filled: true,
//                       fillColor: Colors.white,
//                       isDense: true,
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.black)),
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.black))),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   ListView buildContentListReport(ReportMonitorModel reportMonitorModel) {
//     return ListView.builder(
//       itemCount: reportMonitorModel.data.length + 1,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         if (index == reportMonitorModel.data.length) {
//           return _buildSkeletonOneDataListLoading();
//         } else {
//           return Card(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               decoration: BoxDecoration(
//                 color: ColorHelpers.colorBackground,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                           (_itemFilter.toLowerCase() == "suhu")
//                               ? reportMonitorModel.data[index].temperature
//                               : (_itemFilter.toLowerCase() == "tekanan")
//                                   ? reportMonitorModel.data[index].pressure
//                                   : (_itemFilter.toLowerCase() == "arus r")
//                                       ? reportMonitorModel.data[index].arusR
//                                       : (_itemFilter.toLowerCase() == "arus s")
//                                           ? reportMonitorModel.data[index].arusS
//                                           : (_itemFilter.toLowerCase() ==
//                                                   "arus t")
//                                               ? reportMonitorModel
//                                                   .data[index].arusT
//                                               : (_itemFilter.toLowerCase() ==
//                                                       "arus ac")
//                                                   ? reportMonitorModel
//                                                       .data[index].arusAc
//                                                   : (_itemFilter
//                                                               .toLowerCase() ==
//                                                           "tegangan rs")
//                                                       ? reportMonitorModel
//                                                           .data[index]
//                                                           .teganganRs
//                                                       : (_itemFilter
//                                                                   .toLowerCase() ==
//                                                               "tegangan rt")
//                                                           ? reportMonitorModel
//                                                               .data[index]
//                                                               .teganganRt
//                                                           : (_itemFilter
//                                                                       .toLowerCase() ==
//                                                                   "tegangan st")
//                                                               ? reportMonitorModel
//                                                                   .data[index]
//                                                                   .teganganSt
//                                                               : (_itemFilter
//                                                                           .toLowerCase() ==
//                                                                       "tegangan rn")
//                                                                   ? reportMonitorModel
//                                                                       .data[
//                                                                           index]
//                                                                       .teganganRn
//                                                                   : (_itemFilter
//                                                                               .toLowerCase() ==
//                                                                           "tegangan sn")
//                                                                       ? reportMonitorModel
//                                                                           .data[
//                                                                               index]
//                                                                           .teganganSn
//                                                                       : reportMonitorModel
//                                                                           .data[
//                                                                               index]
//                                                                           .teganganTn,
//                           style: TextStyle(
//                               fontSize: 22, fontWeight: FontWeight.w500)),
//                       UIHelper.horizontalSpaceVerySmall,
//                       Text(
//                           (_itemFilter.toLowerCase() == "suhu")
//                               ? "Celcius"
//                               : (_itemFilter.toLowerCase() == "tekanan")
//                                   ? "Psi"
//                                   : (_itemFilter.toLowerCase() == "arus r" ||
//                                           _itemFilter.toLowerCase() ==
//                                               "arus s" ||
//                                           _itemFilter.toLowerCase() ==
//                                               "arus t" ||
//                                           _itemFilter.toLowerCase() ==
//                                               "arus ac")
//                                       ? "Ampere"
//                                       : (_itemFilter.toLowerCase() ==
//                                                   "tegangan rs" ||
//                                               _itemFilter.toLowerCase() ==
//                                                   "tegangan rt" ||
//                                               _itemFilter.toLowerCase() ==
//                                                   "tegangan st" ||
//                                               _itemFilter.toLowerCase() ==
//                                                   "tegangan rn" ||
//                                               _itemFilter.toLowerCase() ==
//                                                   "tegangan sn")
//                                           ? "Volt"
//                                           : "-",
//                           style: TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                   UIHelper.verticalSpaceSmall,
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.access_time,
//                         color: Colors.blue,
//                         size: 22,
//                       ),
//                       UIHelper.horizontalSpaceVerySmall,
//                       Text(
//                           DateFormat("HH:mm").format(DateTime.parse(
//                                   reportMonitorModel.data[index].createdAt)
//                               .toLocal()),
//                           style:
//                               TextStyle(color: Colors.black.withOpacity(0.6))),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

//   _generateData(ReportMonitorModel report, String filter) {
//     List<ChartReport> lineSalesdata = List<ChartReport>();
//     setState(() {
//       report.data.map((element) {
//         if (filter.toLowerCase() == "suhu") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.temperature)));
//         } else if (filter.toLowerCase() == "tekanan") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.pressure)));
//         } else if (filter.toLowerCase() == "arus r") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.arusR)));
//         } else if (filter.toLowerCase() == "arus s") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.arusS)));
//         } else if (filter.toLowerCase() == "arus t") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.arusT)));
//         } else if (filter.toLowerCase() == "arus ac") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.arusAc)));
//         } else if (filter.toLowerCase() == "tegangan rs") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.teganganRs)));
//         } else if (filter.toLowerCase() == "tegangan st") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.teganganSt)));
//         } else if (filter.toLowerCase() == "tegangan rn") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.teganganRn)));
//         } else if (filter.toLowerCase() == "tegangan sn") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.teganganSn)));
//         } else if (filter.toLowerCase() == "tegangan tn") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.teganganTn)));
//         } else if (filter.toLowerCase() == "tegangan rt") {
//           lineSalesdata.add(ChartReport(
//               DateTime.parse(element.createdAt).toLocal(),
//               double.parse(element.teganganRt)));
//         }
//       }).toList();

//       _seriesLineData.add(
//         charts.Series(
//           colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blue),
//           id: 'Air Pollution',
//           data: lineSalesdata,
//           domainFn: (ChartReport report, _) => report.time,
//           measureFn: (ChartReport report, _) => report.data,
//         ),
//       );

//       lineChart = charts.TimeSeriesChart(_seriesLineData,
//           defaultRenderer:
//               new charts.LineRendererConfig(includeArea: true, stacked: true),
//           animate: true,
//           animationDuration: Duration(seconds: 5),
//           behaviors: [
//             new charts.ChartTitle('Hari',
//                 behaviorPosition: charts.BehaviorPosition.bottom,
//                 titleOutsideJustification:
//                     charts.OutsideJustification.middleDrawArea),
//             new charts.ChartTitle(_itemFilter,
//                 behaviorPosition: charts.BehaviorPosition.start,
//                 titleOutsideJustification:
//                     charts.OutsideJustification.middleDrawArea),
//           ]);
//     });
//   }

//   void _getMoreData() async {
//     Dio dio = Dio();
//     print("Page " + _pageIndex.toString());
//     if (!isLoading) {
//       setState(() {
//         isLoading = true;
//       });
//       var fromDate = DateFormat('yyyy-MM-dd').format(this.dateFrom);
//       var toDateText = DateFormat('yyyy-MM-dd').format(this.dateTo),
//           response = await dio.get(
//               BASE_URL +
//                   "/api/v1/monitor?site_id=${widget.siteId}&from=$fromDate&to=$toDateText&limit=10&page=$_pageIndex",
//               options: Options(
//                   headers: {"Authorization": "Bearer ${siteBloc.token}"}));
//       ReportMonitorModel tempList = new ReportMonitorModel();

//       tempList = ReportMonitorModel.fromJson(response.data);

//       setState(() {
//         _pageIndex++;
//         isLoading = false;
//         listReportBloc.setListReport(tempList.data);
//       });
//     }
//   }
// }
