import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/bloc/rfid_bloc/rfid_bloc.dart';
import 'package:flutter_monisite/presentation/screen/rfid_detection/widgets/data_rfid_detection_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../external/color_helpers.dart';
import '../../widgets/error_widget.dart';

class ListDataRfidScreen extends StatefulWidget {
  final int siteId;
  const ListDataRfidScreen({super.key, required this.siteId});

  @override
  State<ListDataRfidScreen> createState() => _ListDataRfidScreenState();
}

class _ListDataRfidScreenState extends State<ListDataRfidScreen> {
  late RfidBloc faceBloc;

  @override
  void initState() {
    super.initState();
    faceBloc = BlocProvider.of<RfidBloc>(context);
    faceBloc.add(GetListRfidDetection(widget.siteId, 40));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorHelpers.colorBackground,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Face Detection"),
        ),
        body: BlocConsumer<RfidBloc, RfidState>(
          listener: (context, state) {
            if (state is GetRfidDetectionFailed) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          builder: (context, state) {
            if (state is GetRfidDetectionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetRfidDetectionSuccess) {
              return Padding(
                padding: EdgeInsets.zero,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var data = state.rfidDetectionModel.data?[index];
                    return DataRfidDetectionWidget(dataRfid: data!);
                  },
                  itemCount: state.rfidDetectionModel.data?.length ?? 0,
                ),
              );
            } else if (state is GetRfidDetectionFailed) {
              return ErrorHandlingWidget(
                  icon: "images/laptop.png",
                  title: "Data RFID kosong",
                  subTitle: "Silahkan kembali dalam beberapa saat lagi.");
            } else if (state is GetRfidDetectionFailed) {
              return ErrorHandlingWidget(
                  icon: "images/laptop.png",
                  title: state.message,
                  subTitle: "Silahkan kembali dalam beberapa saat lagi.");
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
