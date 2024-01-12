import 'dart:io' show Platform;

import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../storage.dart';
import 'library/battery.dart';
import 'library/description.dart';
import 'library/du_mode.dart';
import 'library/firmware.dart';
import 'library/inclination.dart';
import 'library/mac.dart';
import 'library/utils.dart';

class EscortDU extends StatefulWidget {
  const EscortDU(
      {Key? key,
      required this.name,
      required this.mac,
      required this.angle,
      required this.mode,
      required this.battery,
      required this.firmware})
      : super(key: key);

  final String name;
  final int angle;
  final int mode;
  final int battery;
  final int firmware;
  final String mac;

  @override
  State<EscortDU> createState() => _EscortDUState();
}

class _EscortDUState extends State<EscortDU> {
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
                            sensorTitle: 'DU',
                            sensorDescription: AppLocalizations.of(context)!
                                .sensorDescriptionTiltAngle,
                            url: 'https://bitlite.ru/eskort-du-ble/',
                          ),
                          const BIDevider(),
                          Platform.isIOS
                              ? SizedBox.shrink()
                              : MAC(mac: widget.mac),
                          Platform.isIOS
                              ? SizedBox.shrink()
                              : const BIDevider(),
                          DUMode(mode: widget.mode),
                          const BIDevider(),
                          Inclination(level: widget.angle),
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
