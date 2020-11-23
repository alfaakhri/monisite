import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';

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
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Color> gradientColors = [
    Colors.blue.shade800,
    Colors.blue.shade300,
  ];

  bool showAvg = false;

  String _itemFilter;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Laporan"),
        ),
        body: ListView(
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
                          });
                        },
                        value: _itemFilter),
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      onTap: () {},
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
                Text('Tower STO Sunter',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: EdgeInsets.only(right: 16.0, left: 6.0),
                child: LineChart(
                  sampleData2(),
                ),
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.only(top: 15),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: ColorHelpers.colorBackground,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('35',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500)),
                                UIHelper.horizontalSpaceVerySmall,
                                Text('Celcius', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            UIHelper.verticalSpaceSmall,
                            Row(
                              children: [
                                Icon(Icons.access_time, color: Colors.blue, size: 22,),
                                UIHelper.horizontalSpaceVerySmall,
                                Text('22:30:25', style: TextStyle(color: Colors.black.withOpacity(0.6))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }

  LineChartData sampleData2() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        // drawVerticalLine: true,
        // getDrawingHorizontalLine: (value) {
        //   return FlLine(
        //     color: const Color(0xff37434d),
        //     strokeWidth: 1,
        //   );
        // },
        // getDrawingVerticalLine: (value) {
        //   return FlLine(
        //     color: const Color(0xff37434d),
        //     strokeWidth: 1,
        //   );
        // },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
