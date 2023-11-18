import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../external/color_helpers.dart';
import '../../../../external/ui_helpers.dart';

class DataRfidShimmer extends StatelessWidget {
  const DataRfidShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 250,
        child: SkeletonAnimation(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                              color: ColorHelpers.colorGrey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 5,
          ),
        ),
      ),
    );
  }
}
