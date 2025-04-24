import 'dart:io' show Platform;

import 'package:ble_inspector/styles.dart';
import 'package:ble_inspector/widgets/library/humidity.dart';
import 'package:ble_inspector/widgets/library/temperature.dart';
import 'package:ble_inspector/widgets/library/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../storage.dart';
import 'library/battery.dart';
import 'library/description.dart';
import 'library/firmware.dart';
import 'library/illumination.dart';
import 'library/mac.dart';

class EscortTH extends StatefulWidget {
  const EscortTH(
      {Key? key,
      required this.name,
      required this.mac,
      required this.temperature,
      required this.humidity,
      required this.battery,
      required this.doorOpen,
      required this.firmware})
      : super(key: key);

  final String name;
  final int temperature;
  final int humidity;
  final int battery;
  final bool doorOpen;
  final int firmware;
  final String mac;

  @override
  State<EscortTH> createState() => _EscortTHState();
}

class _EscortTHState extends State<EscortTH> {
  String savedName = '';

  loadName(String mac) async {
    savedName = await GetSensorName(mac);
  }

  @override
  void initState() {
    loadName(widget.mac);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                savedName.isEmpty ? widget.name : savedName,
                style: Styles.deviceName,
              ),
            ),
            CupertinoButton(
              onPressed: () {
                showCupertinoDialog<void>(
                  context: context,
                  builder: (BuildContext context) => SaveAsDialog(
                    name: widget.name,
                    mac: widget.mac,
                  ),
                ).then((_) => setState(() {
                      loadName(widget.mac);
                    }));
              },
              child: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Styles.deviceBackground,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SensorDescription(
                            manufacturer: 'ESCORT',
                            sensorTitle: 'TH',
                            sensorDescription: AppLocalizations.of(context)!
                                .sensorDescriptionTemperature,
                            url: 'https://bitlite.ru/eskort-th-ble/',
                          ),
                          const BIDevider(),
                          Platform.isIOS
                              ? const SizedBox.shrink()
                              : MAC(mac: widget.mac),
                          Platform.isIOS
                              ? const SizedBox.shrink()
                              : const BIDevider(),
                          Temperature(degrees: widget.temperature),
                          const BIDevider(),
                          Humidity(level: widget.humidity),
                          const BIDevider(),
                          Battery(level: widget.battery),
                          const BIDevider(),
                          EscortFirmware(version: widget.firmware),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
