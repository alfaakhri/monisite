import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../../external/ui_helpers.dart';
import '../../../shared/cached_image.dart';

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
                      CachedImageRounded(
                        imageUrl: "",
                        width: 90,
                        height: 80,
                      ),
                      UIHelper.horizontalSpaceVerySmall,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.person, color: Colors.blue, size: 22),
                                UIHelper.horizontalSpaceVerySmall,
                                Text("Name: Wira"),
                              ],
                            ),
                            UIHelper.verticalSpaceVerySmall,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.blue,
                                  size: 22,
                                ),
                                UIHelper.horizontalSpaceVerySmall,
                                Expanded(
                                    child: Text(
                                  "Jumat, 18 Agustus 2023. 21:00",
                                  maxLines: 2,
                                )),
                              ],
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
      }
    );
  }
}