import 'package:ble_inspector/styles.dart';
import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utils.dart';

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
