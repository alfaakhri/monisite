import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../external/color_helpers.dart';
import '../../../../external/ui_helpers.dart';

class DetailSiteMonitorShimmer extends StatelessWidget {
  const DetailSiteMonitorShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: 85,
                  height: 25,
                  decoration: BoxDecoration(
                    color: ColorHelpers.colorGrey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: 250,
                        height: 35,
                        decoration: BoxDecoration(
                          color: ColorHelpers.colorGrey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.text_snippet,
                                color: Colors.white, size: 20),
                            UIHelper.horizontalSpaceVerySmall,
                            Container(
                              width: 150,
                              height: 10,
                              decoration: BoxDecoration(
                                color: ColorHelpers.colorGrey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.cloud, color: Colors.white, size: 20),
                            UIHelper.horizontalSpaceVerySmall,
                            Container(
                              width: 150,
                              height: 10,
                              decoration: BoxDecoration(
                                color: ColorHelpers.colorGrey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceVerySmall,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.place, color: Colors.white, size: 20),
                            UIHelper.horizontalSpaceVerySmall,
                            Expanded(
                              child: Container(
                                width: 150,
                                height: 25,
                                decoration: BoxDecoration(
                                  color:
                                      ColorHelpers.colorGrey.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            )
                          ],
                        ),
                        UIHelper.verticalSpaceMedium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(15.0),
              color: ColorHelpers.colorBackground,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorHelpers.colorGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorHelpers.colorGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorHelpers.colorGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorHelpers.colorGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ]))
        ],
      ),
    ));
  }
}
