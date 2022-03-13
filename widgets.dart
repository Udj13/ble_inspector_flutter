import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io' show Platform;

const locale = 'ru';
const rowEdge = EdgeInsets.fromLTRB(0, 5, 15, 5);

class EscortTL extends StatefulWidget {
  const EscortTL(
      {Key? key,
      required this.name,
      required this.mac,
      required this.temperature,
      required this.illumination,
      required this.battery,
      required this.firmware})
      : super(key: key);

  final String name;
  final int temperature;
  final int illumination;
  final int battery;
  final int firmware;
  final String mac;

  @override
  State<EscortTL> createState() => _EscortTLState();
}

class _EscortTLState extends State<EscortTL> {
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
                            sensorTitle: 'TL',
                            sensorDescription: AppLocalizations.of(context)!
                                .sensorDescriptionTemperature,
                            url: 'https://bitlite.ru/eskort-tl-ble/',
                          ),
                          const BIDevider(),
                          Platform.isIOS
                              ? SizedBox.shrink()
                              : MAC(mac: widget.mac),
                          Platform.isIOS
                              ? SizedBox.shrink()
                              : const BIDevider(),
                          Temperature(degrees: widget.temperature),
                          const BIDevider(),
                          Illumination(level: widget.illumination),
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

class SaveAsDialog extends StatefulWidget {
  const SaveAsDialog({
    Key? key,
    required this.name,
    required this.mac,
  }) : super(key: key);

  final String name;
  final String mac;

  @override
  State<SaveAsDialog> createState() => _SaveAsDialogState();
}

class _SaveAsDialogState extends State<SaveAsDialog> {
  late TextEditingController _textController;
  String newValue = '';
  String sensorName = '';

  @override
  void initState() {
    loadName();
    _textController = TextEditingController(text: sensorName);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  loadName() async {
    sensorName = await GetSensorName(widget.mac);
    newValue = sensorName;
    _textController = TextEditingController(text: sensorName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.name),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.newLocalName,
            style: Styles.deviceDataLabel,
          ),
          CupertinoTextField(
            controller: _textController,
            textInputAction: TextInputAction.next,
            restorationId: AppLocalizations.of(context)!.newName,
            placeholder: sensorName,
            clearButtonMode: OverlayVisibilityMode.editing,
            autocorrect: false,
            onChanged: (value) {
              newValue = value;
            },
          ),
        ],
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text(AppLocalizations.of(context)!.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text(AppLocalizations.of(context)!.saveAs),
          isDestructiveAction: false,
          onPressed: () async {
            await SetSensorName(widget.mac, newValue);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class EscortTD extends StatefulWidget {
  const EscortTD(
      {Key? key,
      required this.name,
      required this.mac,
      required this.fuelData,
      required this.fuelLevel,
      required this.temperature,
      required this.battery,
      required this.firmware})
      : super(key: key);

  final String name;
  final int fuelData;
  final int fuelLevel;
  final int temperature;
  final int battery;
  final int firmware;
  final String mac;

  @override
  State<EscortTD> createState() => _EscortTDState();
}

class _EscortTDState extends State<EscortTD> {
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
                            url: 'https://bitlite.ru/eskort-td-ble/',
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
                          Battery(level: widget.battery),
                          const BIDevider(),
                          Temperature(degrees: widget.temperature),
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

class MieltaFantom extends StatefulWidget {
  const MieltaFantom({
    Key? key,
    required this.name,
    required this.mac,
    required this.fuelData,
    required this.fuelLevelInPercent,
    required this.temperature,
    required this.inclination,
    required this.battery,
  }) : super(key: key);

  final String name;
  final int fuelData;
  final int fuelLevelInPercent;
  final int temperature;
  final int inclination;
  final int battery;
  final String mac;

  @override
  State<MieltaFantom> createState() => _MieltaFantomState();
}

class _MieltaFantomState extends State<MieltaFantom> {
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
                            manufacturer: 'MIELTA',
                            sensorTitle: 'FANTOM',
                            sensorDescription: AppLocalizations.of(context)!
                                .sensorDescriptionFuelLevel,
                            url: 'https://bitlite.ru/mielta-fantom/',
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
                          FuelLevelInPercent(
                              percent: widget.fuelLevelInPercent),
                          const BIDevider(),
                          Temperature(degrees: widget.temperature),
                          const BIDevider(),
                          Inclination(level: widget.inclination),
                          const BIDevider(),
                          Battery(level: widget.battery),
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

class SensorDescription extends StatelessWidget {
  const SensorDescription(
      {Key? key,
      required this.manufacturer,
      required this.sensorTitle,
      required this.sensorDescription,
      required this.url})
      : super(key: key);
  final String manufacturer;
  final String sensorTitle;
  final String sensorDescription;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                CupertinoIcons.doc_text,
                color: Styles.deviceDescriptionIconColor,
              ),
              const SizedBox(width: 5),
              Text(
                manufacturer,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              Text(
                sensorDescription,
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                sensorTitle,
                style: Styles.deviceDataText,
              ),
              CupertinoButton(
                onPressed: () async {
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                child: const Icon(CupertinoIcons.book),
                padding: const EdgeInsets.all(0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FuelData extends StatelessWidget {
  const FuelData({Key? key, required this.data}) : super(key: key);
  final int data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.local_gas_station,
                color: Styles.fuelDataIconColor,
              ),
              SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.fuelData,
                style: Styles.deviceParametrLabel,
              ),
            ],
          ),
          Text(
            NumberFormat('###,###', locale).format(data),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}

class FuelLevel extends StatelessWidget {
  const FuelLevel({Key? key, required this.level}) : super(key: key);
  final int level;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.local_gas_station,
                color: Styles.fuelDataIconColor,
              ),
              SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.fuelLevel,
                style: Styles.deviceParametrLabel,
              ),
              SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.liters,
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            NumberFormat('###,###', locale).format(level),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}

class FuelLevelInPercent extends StatelessWidget {
  const FuelLevelInPercent({Key? key, required this.percent}) : super(key: key);
  final int percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                CupertinoIcons.percent,
                color: Styles.fuelDataIconColor,
              ),
              SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.fuelLevel,
                style: Styles.deviceParametrLabel,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$percent%',
                style: Styles.deviceDataText,
              ),
              CupertinoProgressBar(
                value: percent / 100,
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Illumination extends StatelessWidget {
  const Illumination({Key? key, required this.level}) : super(key: key);
  final int level;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                level > 100
                    ? CupertinoIcons.brightness_solid
                    : CupertinoIcons.moon_fill,
                color: level > 100
                    ? Styles.illuminationIconColorHi
                    : Styles.illuminationIconColorLow,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.illumination,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.lux,
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            NumberFormat('###,###', locale).format(level),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}

class Battery extends StatelessWidget {
  const Battery({Key? key, required this.level}) : super(key: key);
  final int level;

  IconData _getBatteryIcon(int volts) {
    if (volts > 34) return CupertinoIcons.battery_full;
    if (volts > 32) return CupertinoIcons.battery_75_percent;
    if (volts > 30) return CupertinoIcons.battery_25_percent;
    return CupertinoIcons.battery_empty;
  }

  Color _getBatteryIconColor(int volts) {
    if (volts > 32) return Styles.batteryIconColorOk;
    return Styles.batteryIconColorLow;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                _getBatteryIcon(level),
                color: _getBatteryIconColor(level),
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.battery,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.volts,
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            (level / 10).toString(),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}

class Temperature extends StatelessWidget {
  const Temperature({Key? key, required this.degrees}) : super(key: key);
  final int degrees;

  IconData _getTemperatureIcon(int degrees) {
    if (degrees > 25) return CupertinoIcons.thermometer_sun;
    if (degrees < -5) return CupertinoIcons.thermometer_snowflake;
    return CupertinoIcons.thermometer;
  }

  Color _getTemperatureIconColor(int degrees) {
    if (degrees > 25) return Styles.temperatureIconColorHi;
    if (degrees < -5) return Styles.temperatureIconColorLow;
    return Styles.temperatureIconColorNormal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                _getTemperatureIcon(degrees),
                color: _getTemperatureIconColor(degrees),
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.temperature,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              const Text(
                '°C',
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            degrees.toString(),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}

class Inclination extends StatelessWidget {
  const Inclination({Key? key, required this.level}) : super(key: key);
  final int level;

  @override
  Widget build(BuildContext context) {
    final radians = 2 * 3.14 * level / 360;
    final iconTransform =
        Matrix4.translationValues(10 * radians, -15 * radians, 0) *
            Matrix4.rotationZ(radians);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Transform(
                transform: iconTransform,
                child: const Icon(
                  CupertinoIcons.rotate_right_fill,
                  color: Styles.inclinationDataIconColor,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.inclination,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              const Text(
                '°',
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            level.toString(),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}

class EscortFirmware extends StatelessWidget {
  const EscortFirmware({Key? key, required this.version}) : super(key: key);
  final int version;

  String getFirmwareString(int version) {
    final fw1 = version ~/ 100;
    final fw2 = (version - fw1 * 100) ~/ 10;
    final fw3 = version - fw1 * 100 - fw2 * 10;

    return '$fw1.$fw2.$fw3';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                CupertinoIcons.cube_box,
                color: Styles.firmwareIconColor,
              ),
              SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.firmware,
                style: Styles.deviceParametrLabel,
              ),
              SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.version,
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            getFirmwareString(version),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}

class MAC extends StatelessWidget {
  const MAC({Key? key, required this.mac}) : super(key: key);
  final String mac;

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                CupertinoIcons.link,
                color: Styles.macIconColor,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.mac,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              Text(
                mac,
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Tooltip(
                message: AppLocalizations.of(context)!.copied,
                key: key,
                showDuration: Duration(seconds: 2),
                child: CupertinoButton(
                  onPressed: () {
                    final dynamic tooltip = key.currentState;
                    tooltip.ensureTooltipVisible();

                    ClipboardData clipboardData = ClipboardData(text: mac);
                    Clipboard.setData(clipboardData);
                  },
                  padding: const EdgeInsets.all(0),
                  child: const Icon(Icons.copy),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BIDevider extends StatelessWidget {
  const BIDevider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      thickness: 1,
      indent: 20,
      endIndent: 0,
      color: Styles.deviceRowDivider,
    );
  }
}
