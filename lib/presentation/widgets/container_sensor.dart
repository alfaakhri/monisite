import 'package:flutter/material.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';

class ContainerSensor extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String data;
  final String unit;

  const ContainerSensor(
      {Key? key, required this.iconData, required this.title, required this.data, required this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelpers.colorWhite,
        borderRadius: new BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 220,
                child: Row(
                  children: <Widget>[
                    Icon(
                      iconData,
                      size: 35,
                      color: Colors.blue,
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          unit,
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Text(
                  data,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
