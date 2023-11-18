import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/bloc/detail_rfid_bloc/detail_rfid_bloc.dart';
import 'package:flutter_monisite/domain/provider/rfid_provider.dart';
import 'package:flutter_monisite/external/date_format_extension.dart';
import 'package:flutter_monisite/presentation/screen/rfid_detection/widgets/data_detail_record_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../external/ui_helpers.dart';

class ListDetailRecordRFID extends StatefulWidget {
  final int siteId;
  final int idRfid;
  const ListDetailRecordRFID(
      {super.key, required this.siteId, required this.idRfid});

  @override
  State<ListDetailRecordRFID> createState() => _ListDetailRecordRFIDState();
}

class _ListDetailRecordRFIDState extends State<ListDetailRecordRFID> {
  late DetailRfidBloc faceBloc;

  @override
  void initState() {
    super.initState();
    faceBloc = BlocProvider.of<DetailRfidBloc>(context);
    faceBloc.add(GetListRfidDetection(widget.siteId, widget.idRfid));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailRfidBloc, DetailRfidState>(
        listener: (context, state) {
      if (state is GetRfidDetectionFailed) {
        Fluttertoast.showToast(msg: state.message);
      } else if (state is GetRfidDetectionSuccess) {
        context
            .read<RFIDProvider>()
            .setListRecordRFID(state.rfidDetectionModel.data?.records ?? []);
      }
    }, builder: (context, state) {
      if (state is GetRfidDetectionLoading) {
        return DataDetailRecordShimmer();
      } else if (state is GetRfidDetectionSuccess) {
        var data = state.rfidDetectionModel.data?.records ?? [];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpaceMedium,
              Text(
                "Record Time",
                style: TextStyle(fontSize: 24),
              ),
              UIHelper.verticalSpaceVerySmall,
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.blue,
                                size: 22,
                              ),
                              UIHelper.horizontalSpaceVerySmall,
                              Text(
                                  "${DateTime.parse(item.createdAt!).toLocal().dayddMMMMyyyy()}. ${DateTime.parse(item.createdAt!).toLocal().hhmm()}")
                            ],
                          ),
                          UIHelper.verticalSpaceSmall,
                        ],
                      );
                    }),
              )
            ],
          ),
        );
      } else if (state is GetRfidDetectionEmpty) {
        return Container();
      } else if (state is GetRfidDetectionFailed) {
        return Container();
      }
      return DataDetailRecordShimmer();
    });
  }
}
