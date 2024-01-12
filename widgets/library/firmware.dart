import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utils.dart';

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
