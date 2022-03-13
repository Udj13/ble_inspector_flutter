import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'widgets.dart';

Widget? GetSensor(AdvertisementData data, String mac) {
  if (kDebugMode) {
    print(data);
  }

  if ((data.localName.isNotEmpty) && (data.localName.substring(0, 2) == 'MD')) {
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

    if (ready)
      return MieltaFantom(
          name: data.localName,
          mac: mac,
          fuelData: fuelLevel,
          fuelLevelInPercent: percent,
          temperature: temperature,
          inclination: inclination,
          battery: battery);
  }

  if ((data.localName.isNotEmpty) && (data.localName.substring(0, 2) == 'TL')) {
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

    if (ready)
      return EscortTL(
          name: data.localName,
          mac: mac,
          temperature: temperature,
          illumination: illumination,
          battery: battery,
          firmware: firmware);
  }

  if ((data.localName.isNotEmpty) && (data.localName.substring(0, 2) == 'TD')) {
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

    if (ready)
      return EscortTD(
          name: data.localName,
          mac: mac,
          fuelData: fuelData,
          fuelLevel: fuelLevel,
          temperature: temperature,
          battery: battery,
          firmware: firmware);
  }

  return null;
}
