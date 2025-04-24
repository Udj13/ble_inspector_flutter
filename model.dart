import 'package:ble_inspector/widgets/escort_tw.dart';
import 'package:ble_inspector/widgets/escort_th.dart';
import 'package:ble_inspector/widgets/unknown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'widgets/escort_du.dart';
import 'widgets/escort_td.dart';
import 'widgets/escort_tl.dart';
import 'widgets/mielta_fantom.dart';

Widget? GetSensor(AdvertisementData data, String mac, bool showAllSensors) {
  // if (kDebugMode) {
  //   print(data);
  // }

  if ((data.advName.isNotEmpty) && (data.advName.substring(0, 2) == 'TW')) {
    if (kDebugMode) print('Sensor TW found');
    if (kDebugMode) print(data);

    int fuelLevel = 0;
    int fuelData = 0;
    int battery = 0;
    int temperature = 0;
    int firmware = 0;
    bool ready = false;

    data.manufacturerData.forEach((key, value) {
      if (value.length == 12) {
        fuelLevel = value[1] + value[2] * 256;
        fuelData = value[6] + value[7] * 256;
        battery = value[3];
        temperature = value[4];
        temperature > 127 ? temperature -= 256 : {};
        firmware = value[5];
        ready = true;
      }
    });

    if (ready) {
      return EscortTW(
          name: data.advName,
          mac: mac,
          fuelData: fuelData,
          fuelLevel: fuelLevel,
          temperature: temperature,
          battery: battery,
          firmware: firmware);
    }
  }

  if ((data.advName.isNotEmpty) && (data.advName.substring(0, 2) == 'DU')) {
    // if (kDebugMode) print('Sensor DU found');
    // if (kDebugMode) print(data);

    int angle = 0;
    int mode = 0;
    int battery = 0;
    int firmware = 0;
    bool ready = false;

    data.manufacturerData.forEach((key, value) {
      if (value.length == 12) {
        mode = value[1];
        angle = value[6];
        battery = value[10];
        firmware = value[11];
        ready = true;
      }
    });

    if (ready) {
      return EscortDU(
          name: data.advName,
          mac: mac,
          angle: angle,
          mode: mode,
          battery: battery,
          firmware: firmware);
    }
  }

  if ((data.advName.isNotEmpty) && (data.advName.substring(0, 2) == 'MD')) {
    //print('Sensor MIELTA found');

    int percent = 0;
    int battery = 0;
    int temperature = 0;
    int inclination = 0;
    int fuelLevel = 0;
    bool ready = false;

    data.manufacturerData.forEach((key, value) {
      if (value.length == 7) {
        fuelLevel = value[1] * 256 + value[0];
        percent = value[2];
        battery = value[3];
        temperature = value[4];
        temperature > 127 ? temperature -= 256 : {};
        inclination = value[5];
        ready = true;
      }
    });

    if (ready) {
      return MieltaFantom(
          name: data.advName,
          mac: mac,
          fuelData: fuelLevel,
          fuelLevelInPercent: percent,
          temperature: temperature,
          inclination: inclination,
          battery: battery);
    }
  }

  if ((data.advName.isNotEmpty) && (data.advName.substring(0, 2) == 'TL')) {
    //print('Temp. sensor ESCORT found');

    int illumination = 0;
    int battery = 0;
    int temperature = 0;
    int tempSign = 0;
    int firmware = 0;
    bool ready = false;

    data.manufacturerData.forEach((key, value) {
      if (value.length == 7) {
        illumination = value[3] + value[4] * 256;
        battery = value[5];
        tempSign = value[2];
        tempSign == 255
            ? temperature = (value[1] - 256) ~/ 10
            : temperature = value[1] ~/ 10;
        firmware = value[6];
        ready = true;
      }
    });

    if (ready) {
      return EscortTL(
          name: data.advName,
          mac: mac,
          temperature: temperature,
          illumination: illumination,
          battery: battery,
          firmware: firmware);
    }
  }

  if ((data.advName.isNotEmpty) && (data.advName.substring(0, 2) == 'TD')) {
    //print('Fuel level sensor ESCORT found');

    int fuelLevel = 0;
    int fuelData = 0;
    int battery = 0;
    int temperature = 0;
    int firmware = 0;
    bool ready = false;

    data.manufacturerData.forEach((key, value) {
      if (value.length == 12) {
        fuelLevel = value[1] + value[2] * 256;
        fuelData = value[6] + value[7] * 256;
        battery = value[3];
        temperature = value[4];
        temperature > 127 ? temperature -= 256 : {};
        firmware = value[5];
        ready = true;
      }
    });

    if (ready) {
      return EscortTD(
          name: data.advName,
          mac: mac,
          fuelData: fuelData,
          fuelLevel: fuelLevel,
          temperature: temperature,
          battery: battery,
          firmware: firmware);
    }
  }

  if ((data.advName.isNotEmpty) && (data.advName.substring(0, 2) == 'TH')) {
    //print('Temp. sensor ESCORT found');

    int battery = 0;
    int temperature = 0;
    int humidity = 0;
    bool doorOpen = false;
    int firmware = 0;
    bool ready = false;

    data.manufacturerData.forEach((key, value) {
      if (value.length >= 11) {
        temperature = (value[2] * 256 + value[1]) ~/ 10;
        temperature > 127 ? temperature -= 256 : {};

        humidity = (value[5] + value[6] * 256) ~/ 10;

        battery = value[10];
        doorOpen = value[9] == 11; // 11 - enabled, 3 - disabled
        firmware = value[11];
        ready = true;
      }
    });

    if (ready) {
      return EscortTH(
          name: data.advName,
          mac: mac,
          temperature: temperature,
          humidity: humidity,
          battery: battery,
          doorOpen: doorOpen,
          firmware: firmware);
    }
  }

  if (showAllSensors) {
    bool ready = false;
    String bleAdvertising = '';
    data.manufacturerData.forEach((key, value) {
      if (value.length != 0) {
        value.forEach((element) {
          bleAdvertising += '$value ';
        });
        ready = true;
      }
    });

    if (ready) {
      return UnknownSensor(
        name: data.advName,
        mac: mac,
        bleAdvertising: bleAdvertising,
      );
    }
  }

  return null;
}
