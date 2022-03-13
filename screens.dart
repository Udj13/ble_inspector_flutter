import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CupertinoBluetoothOffPage extends StatelessWidget {
  const CupertinoBluetoothOffPage({Key? key, required this.state})
      : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.scaffoldBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context)!.bleInspector),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Column(children: [
                      SizedBox(height: 50),
                      Icon(
                        Icons.bluetooth_disabled,
                        size: 40.0,
                        color: Styles.batteryIconColorLow,
                      ),
                      SizedBox(height: 30),
                      Text(
                          'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
                          style: Styles.deviceName),
                      SizedBox(height: 30),
                      Text(AppLocalizations.of(context)!.enableBluetooth,
                          style: Styles.deviceDataLabel),
                      SizedBox(height: 50),
                    ]),
                  ),
                ),
                SizedBox(height: 50),
              ]),
        ),
      ),
    );
  }
}
