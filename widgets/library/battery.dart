import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utils.dart';

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
