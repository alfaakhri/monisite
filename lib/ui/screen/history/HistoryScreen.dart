import 'package:flutter/material.dart';
import 'package:flutter_monisite/ui/screen/history/CompleteHistoryScreen.dart';
import 'package:flutter_monisite/ui/screen/history/ProcessHistoryScreen.dart';

class HistoryScreen extends StatefulWidget {
  static const String id = "history_screen";
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}
 
class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text('Riwayat'),
        bottom: new TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          tabs: <Tab>[
            new Tab(
              text: "Proses",
            ),
            new Tab(
              text: "Selesai",
            ),
          ],
          controller: tabController,
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          ProcessHistoryScreen(),
          CompleteHistoryScreen()
        ],
        controller: tabController,
      ),
      
    );
  }
}

