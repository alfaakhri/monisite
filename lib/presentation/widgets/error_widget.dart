import 'package:flutter/material.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';

class ErrorHandlingWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;

  const ErrorHandlingWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                icon,
                width: 30,
                height: 30,
              ),
              decoration: BoxDecoration(
                color: ColorHelpers.colorGreyTextLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            UIHelper.verticalSpaceSmall,
            Text(
              subTitle,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
