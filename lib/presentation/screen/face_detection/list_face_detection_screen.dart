import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/presentation/screen/face_detection/widgets/data_face_detection_shimmer.dart';
import 'package:flutter_monisite/presentation/screen/face_detection/widgets/data_face_detection_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/bloc/face_detection_bloc/face_detection_bloc.dart';
import '../../../external/color_helpers.dart';
import '../../widgets/error_widget.dart';

class ListFaceDetectionScreen extends StatefulWidget {
  final int siteId;
  const ListFaceDetectionScreen({super.key, required this.siteId});

  @override
  State<ListFaceDetectionScreen> createState() =>
      _ListFaceDetectionScreenState();
}

class _ListFaceDetectionScreenState extends State<ListFaceDetectionScreen> {
  late FaceDetectionBloc faceBloc;

  @override
  void initState() {
    super.initState();
    faceBloc = BlocProvider.of<FaceDetectionBloc>(context);
    faceBloc.add(GetListFaceDetection(widget.siteId, 40));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorHelpers.colorBackground,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Face Detection"),
        ),
        body: BlocConsumer<FaceDetectionBloc, FaceDetectionState>(
          listener: (context, state) {
            if (state is GetFaceDetectionFailed) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          builder: (context, state) {
            if (state is GetFaceDetectionLoading) {
              return DataFaceDetectionShimmer();
            } else if (state is GetFaceDetectionSuccess) {
              return Padding(
                padding: EdgeInsets.zero,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var data = state.faceDetectionModel.data?[index];
                    return DataFaceDetectionWidget(data: data);
                  },
                  itemCount: state.faceDetectionModel.data?.length ?? 0,
                ),
              );
            } else if (state is GetFaceDetectionEmpty) {
              return ErrorHandlingWidget(
                  icon: "images/laptop.png",
                  title: "Data pendeteksi wajah kosong",
                  subTitle: "Silahkan kembali dalam beberapa saat lagi.");
            } else if (state is GetFaceDetectionFailed) {
              return ErrorHandlingWidget(
                  icon: "images/laptop.png",
                  title: state.message,
                  subTitle: "Silahkan kembali dalam beberapa saat lagi.");
            }
            return DataFaceDetectionShimmer();
          },
        ));
  }
}
