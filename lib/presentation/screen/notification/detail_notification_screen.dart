import 'package:flutter/material.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailNotificationScreen extends StatefulWidget {
  @override
  _DetailNotificationScreenState createState() =>
      _DetailNotificationScreenState();
}

class _DetailNotificationScreenState extends State<DetailNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blue.shade50,
                  child: Image.asset(
                    "images/tower.png",
                    height: 100,
                  )),
            ),
            UIHelper.verticalSpaceSmall,
            Container(
              child: Text("HIGH TEMPERATURE", style: TextStyle(fontSize: 20)),
            ),
            UIHelper.verticalSpaceMedium,
            Text("Tower STO Sunter"),
            UIHelper.verticalSpaceVerySmall,
            Text("Tenant OM: SmartFren"),
            UIHelper.verticalSpaceVerySmall,
            Container(
                child: Text(
              "STO Telkom Sunter Jalan Kedondong Raya Tanjung Priuk Jakarta Utara",
              textAlign: TextAlign.center,
            )),
            UIHelper.verticalSpaceLarge,
            Container(
              child: Material(
                elevation: 5,
                child: RaisedButton(
                  color: ColorHelpers.colorBlue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {

                  },
                  child: Text("Accept", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
