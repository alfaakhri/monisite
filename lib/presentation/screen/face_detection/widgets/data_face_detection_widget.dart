import 'package:flutter/material.dart';
import 'package:flutter_monisite/data/models/face_detection/face_detection_model.dart';
import 'package:flutter_monisite/external/date_format_extension.dart';
import 'package:get/get.dart';

import '../../../../external/ui_helpers.dart';
import '../../../shared/cached_image.dart';

class DataFaceDetectionWidget extends StatelessWidget {
  final DataFaceDetection? data;
  const DataFaceDetectionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              CachedImageRounded(
                imageUrl: "",
                width: 90,
                fit: BoxFit.cover,
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
                        Text("Name: ${data?.name?.capitalizeFirst ?? "-"}"),
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
                          "${DateTime.parse(data!.createdAt!).dayddMMMMyyyy()}. ${DateTime.parse(data!.createdAt!).hhmm()}",
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
    );
  }
}
