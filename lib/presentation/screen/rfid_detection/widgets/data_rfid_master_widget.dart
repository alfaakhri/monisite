import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/rfid_detection/rfid_master_model.dart';
import '../../../../external/ui_helpers.dart';
import '../list_detail_record_rfid_screen.dart';

class DataRFIDMasterWidget extends StatefulWidget {
  final DataRFIDMaster dataRfid;
  final int siteId;
  const DataRFIDMasterWidget(
      {super.key, required this.dataRfid, required this.siteId});

  @override
  State<DataRFIDMasterWidget> createState() => _DataRFIDMasterWidgetState();
}

class _DataRFIDMasterWidgetState extends State<DataRFIDMasterWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.memory, color: Colors.blue, size: 22),
                            UIHelper.horizontalSpaceVerySmall,
                            Text("RFID Code: ${widget.dataRfid.code ?? "-"}"),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        Row(
                          children: [
                            Icon(
                              Icons.computer,
                              color: Colors.blue,
                              size: 22,
                            ),
                            UIHelper.horizontalSpaceVerySmall,
                            Expanded(
                                child: Text(
                              "Name: ${widget.dataRfid.name?.capitalizeFirst ?? "-"}",
                              maxLines: 2,
                            )),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        Row(
                          children: [
                            Icon(
                              Icons.smartphone_rounded,
                              color: Colors.blue,
                              size: 22,
                            ),
                            UIHelper.horizontalSpaceVerySmall,
                            Expanded(
                                child: RichText(
                              text: TextSpan(
                                text: 'Status: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: (widget.dataRfid.status ?? false) ? "Exist" : "Not Exist",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          fontSize: 14,
                                          color: (widget.dataRfid.status ?? false) ? Colors.green : Colors.red)),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      child: ElevatedButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                builder: (context) {
                                  return ListDetailRecordRFID(
                                      siteId: widget.siteId,
                                      codeRfid: widget.dataRfid.code ?? "");
                                });
                          },
                          child: Text("Record Time"))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
