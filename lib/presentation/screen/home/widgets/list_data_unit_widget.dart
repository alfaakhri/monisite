import 'package:flutter/material.dart';
import 'package:flutter_monisite/data/models/monitor/monitor_model.dart';
import 'package:flutter_monisite/presentation/widgets/container_sensor.dart';

import '../../../../external/color_helpers.dart';
import '../../../../external/ui_helpers.dart';

class ListDataUnitWidget extends StatelessWidget {
  final MonitorModel monitor;
  const ListDataUnitWidget({super.key, required this.monitor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      color: ColorHelpers.colorBackground,
      child: Column(
        children: <Widget>[
          // (monitor.data != null)
          //     ? Text("Alat sensor belum terpasang !")
          //     : Text(''),
          ContainerSensor(
            iconData: Icons.ac_unit,
            title: 'Suhu',
            data:
                (monitor.data != null) ? "${monitor.data?.temperature}" : "N/A",
            unit: 'Celcius',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.av_timer,
            title: 'Tekanan',
            data: (monitor.data != null)
                ? "${monitor.data!.pressure ?? "0"}"
                : "N/A",
            unit: 'Psi',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus R',
            data: (monitor.data != null)
                ? "${monitor.data?.arusR ?? "0"}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus S',
            data: (monitor.data != null)
                ? "${monitor.data?.arusS ?? "0"}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus T',
            data: (monitor.data != null)
                ? "${monitor.data?.arusT ?? "0"}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus AC',
            data: (monitor.data != null)
                ? "${monitor.data?.arusAc ?? "0"}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan RS',
            data: (monitor.data != null)
                ? "${monitor.data?.teganganRs ?? "0"}"
                : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan RT',
            data: (monitor.data != null)
                ? "${monitor.data?.teganganRt ?? "0"}"
                : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan ST',
            data: (monitor.data != null)
                ? "${monitor.data?.teganganSt ?? "0"}"
                : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan RN',
            data: (monitor.data != null)
                ? "${monitor.data?.teganganRn ?? "0"}"
                : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan SN',
            data: (monitor.data != null)
                ? "${monitor.data?.teganganSn ?? "0"}"
                : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan TN',
            data: (monitor.data != null)
                ? "${monitor.data?.teganganTn ?? "0"}"
                : "N/A",
            unit: 'Volt',
          ),
        ],
      ),
    );
  }
}
