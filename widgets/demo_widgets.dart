import 'dart:io' show Platform;

import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

Column DemoEscortTL(context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('TL_100645'),
          ),
          CupertinoButton(
            onPressed: () {},
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
                            : MAC(mac: 'E3:2E:FD:ED:7C:AD'),
                        Platform.isIOS ? SizedBox.shrink() : const BIDevider(),
                        Temperature(degrees: 21),
                        const BIDevider(),
                        Illumination(level: 350),
                        const BIDevider(),
                        Battery(level: 34),
                        const BIDevider(),
                        EscortFirmware(version: 129),
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

Column DemoEscortTD(context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('TD_196330'),
          ),
          CupertinoButton(
            onPressed: () {},
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
                            : MAC(mac: 'FD:C4:F1:08:35:37'),
                        Platform.isIOS ? SizedBox.shrink() : const BIDevider(),
                        FuelData(data: 24009),
                        const BIDevider(),
                        FuelLevel(level: 1),
                        const BIDevider(),
                        Battery(level: 35),
                        const BIDevider(),
                        Temperature(degrees: -18),
                        const BIDevider(),
                        EscortFirmware(version: 134),
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

Column DemoMieltaFantom(context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('MD_3830'),
          ),
          CupertinoButton(
            onPressed: () {},
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
                            : MAC(mac: 'AD:D9:96:50:87:E2'),
                        Platform.isIOS ? SizedBox.shrink() : const BIDevider(),
                        FuelData(data: 130),
                        const BIDevider(),
                        FuelLevelInPercent(percent: 16),
                        const BIDevider(),
                        Temperature(degrees: -7),
                        const BIDevider(),
                        Inclination(level: 5),
                        const BIDevider(),
                        Battery(level: 34),
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
