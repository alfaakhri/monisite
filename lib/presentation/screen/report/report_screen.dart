import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_monisite/data/models/ChartReport.dart';

class ReportScreen extends StatefulWidget {
  static const String id = "report_screen";

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<charts.Series<ChartReport, DateTime>> _seriesLineData;

  _generateData() {
    var linesalesdata = [
      new ChartReport(DateTime(2020, 1, 1, 10, 00), 45),
      new ChartReport(DateTime(2020, 1, 1, 11, 00), 56),
      new ChartReport(DateTime(2020, 1, 1, 12, 00), 55),
      new ChartReport(DateTime(2020, 1, 1, 13, 00), 60),
      new ChartReport(DateTime(2020, 1, 1, 14, 00), 61),
      new ChartReport(DateTime(2020, 1, 1, 15, 00), 70),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (ChartReport report, _) => report.time,
        measureFn: (ChartReport report, _) => report.data,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesLineData = List<charts.Series<ChartReport, DateTime>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Tower STO Sunter',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.TimeSeriesChart(_seriesLineData,
                      defaultRenderer: new charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      animate: true,
                      animationDuration: Duration(seconds: 5),
                      behaviors: [
                        new charts.ChartTitle('Hari',
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle('Suhu',
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                      ]),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
