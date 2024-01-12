import 'dart:io' show Platform;

import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../storage.dart';
import 'library/battery.dart';
import 'library/description.dart';
import 'library/firmware.dart';
import 'library/fuel_data.dart';
import 'library/fuel_level.dart';
import 'library/fuel_percent.dart';
import 'library/illumination.dart';
import 'library/inclination.dart';
import 'library/mac.dart';
import 'library/temperature.dart';
import 'library/utils.dart';

// ====== TEMPLATE FOR NEW SENSORS ==============
class Template extends StatefulWidget {
  const Template(
      {Key? key,
      required this.name,
      required this.mac,
      required this.fuelData,
      required this.fuelLevel,
      required this.fuelLevelInPercent,
      required this.temperature,
      required this.illumination,
      required this.inclination,
      required this.battery,
      required this.firmware})
      : super(key: key);

  final String name;
  final int fuelData;
  final int fuelLevel;
  final int fuelLevelInPercent;
  final int temperature;
  final int illumination;
  final int inclination;
  final int battery;
  final int firmware;
  final String mac;

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
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
                            sensorTitle: 'TD',
                            sensorDescription: AppLocalizations.of(context)!
                                .sensorDescriptionFuelLevel,
                            url: 'https://bitlite.ru/',
                          ),
                          const BIDevider(),
                          Platform.isIOS
                              ? SizedBox.shrink()
                              : MAC(mac: widget.mac),
                          Platform.isIOS
                              ? SizedBox.shrink()
                              : const BIDevider(),
                          FuelData(data: widget.fuelData),
                          const BIDevider(),
                          FuelLevel(level: widget.fuelLevel),
                          const BIDevider(),
                          FuelLevelInPercent(
                              percent: widget.fuelLevelInPercent),
                          const BIDevider(),
                          Battery(level: widget.battery),
                          const BIDevider(),
                          Temperature(degrees: widget.temperature),
                          const BIDevider(),
                          Illumination(level: widget.illumination),
                          const BIDevider(),
                          Inclination(level: widget.inclination),
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
// ====== END OF TEMPLATE FOR NEW SENSORS ===========
