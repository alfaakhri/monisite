import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../external/color_helpers.dart';
import '../../../../external/ui_helpers.dart';

class DataFaceDetectionShimmer extends StatelessWidget {
  const DataFaceDetectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return SkeletonAnimation(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () {},
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 90,
                          height: 80,
                          decoration: BoxDecoration(
                              color: ColorHelpers.colorGrey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        UIHelper.horizontalSpaceVerySmall,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 120,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: ColorHelpers.colorGrey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              UIHelper.verticalSpaceVerySmall,
                              Container(
                                width: 150,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: ColorHelpers.colorGrey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
