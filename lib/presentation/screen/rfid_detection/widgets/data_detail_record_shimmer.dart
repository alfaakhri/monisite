import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../external/color_helpers.dart';
import '../../../../external/ui_helpers.dart';

class DataDetailRecordShimmer extends StatelessWidget {
  const DataDetailRecordShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.verticalSpaceMedium,
          Container(
            width: 60,
            height: 20,
            decoration: BoxDecoration(
                color: ColorHelpers.colorGrey,
                borderRadius: BorderRadius.circular(10)),
          ),
          UIHelper.verticalSpaceVerySmall,
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                          color: ColorHelpers.colorGrey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    UIHelper.verticalSpaceVerySmall,
                  ],
                );
              })
        ],
      ),
    );
  }
}
