import 'package:flutter/material.dart';
import 'package:flutter_monisite/ui/shared/Size.dart';
import 'package:flutter_monisite/ui/shared/ui_helpers.dart';

class ContainerSensor extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String data;
  final String unit;

  const ContainerSensor(
      {Key key, this.iconData, this.title, this.data, this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: new BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 190,
                child: Row(
                  children: <Widget>[
                    Icon(
                      iconData,
                      size: 28,
                    ),
                    UIHelper.horizontalSpaceVerySmall,
                    Text(
                      title,
                      style: TextStyle(fontSize: Size().sizeFontSensor),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      data,
                      style: TextStyle(fontSize: 24),
                    ),
                    UIHelper.horizontalSpaceVerySmall,
                    Text(unit),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
