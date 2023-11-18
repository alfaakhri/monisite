import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/provider/rfid_provider.dart';
import 'package:flutter_monisite/presentation/screen/rfid_detection/widgets/data_rfid_master_widget.dart';
import 'package:flutter_monisite/presentation/screen/rfid_detection/widgets/data_rfid_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/bloc/rfid_bloc/rfid_bloc.dart';
import '../../../external/color_helpers.dart';
import '../../widgets/error_widget.dart';

class ListRFIDMasterScreen extends StatefulWidget {
  final int siteId;
  const ListRFIDMasterScreen({super.key, required this.siteId});

  @override
  State<ListRFIDMasterScreen> createState() => _ListRFIDMasterScreenState();
}

class _ListRFIDMasterScreenState extends State<ListRFIDMasterScreen> {
  late RfidBloc faceBloc;

  @override
  void initState() {
    super.initState();
    faceBloc = BlocProvider.of<RfidBloc>(context);
    faceBloc.add(GetRfidMaster(widget.siteId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorHelpers.colorBackground,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("RFID Detection"),
        ),
        body: BlocConsumer<RfidBloc, RfidState>(
          listener: (context, state) {
            if (state is GetRfidMasterFailed) {
              Fluttertoast.showToast(msg: state.message);
            } else if (state is GetRfidMasterSuccess) {
              context
                  .read<RFIDProvider>()
                  .setListDataRFIDMaster(state.rfidMasterModel.data ?? []);
            }
          },
          builder: (context, state) {
            if (state is GetRfidMasterLoading) {
              return DataRfidShimmer();
            } else if (state is GetRfidMasterSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var data =
                      context.watch<RFIDProvider>().dataRFIDMaster[index];
                  return DataRFIDMasterWidget(
                    dataRfid: data,
                    siteId: widget.siteId,
                  );
                },
                itemCount: state.rfidMasterModel.data?.length ?? 0,
              );
            } else if (state is GetRfidMasterEmpty) {
              return ErrorHandlingWidget(
                  icon: "images/laptop.png",
                  title: "Data RFID kosong",
                  subTitle: "Silahkan kembali dalam beberapa saat lagi.");
            } else if (state is GetRfidMasterFailed) {
              return ErrorHandlingWidget(
                  icon: "images/laptop.png",
                  title: state.message,
                  subTitle: "Silahkan kembali dalam beberapa saat lagi.");
            }
            return DataRfidShimmer();
          },
        ));
  }
}
