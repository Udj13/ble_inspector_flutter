import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future<String> GetSensorName(String mac) async {
  prefs = await SharedPreferences.getInstance();
  String savedName = prefs.getString(mac.toString()).toString();
  if (kDebugMode) {
    print('Device $mac saved as $savedName');
  }
  if (savedName == 'null') savedName = '';

  return savedName;
}

SetSensorName(String mac, String newName) async {
  prefs = await SharedPreferences.getInstance();
  if (kDebugMode) {
    print('Saving $mac as $newName');
  }
  prefs.setString(mac.toString(), newName);
}
