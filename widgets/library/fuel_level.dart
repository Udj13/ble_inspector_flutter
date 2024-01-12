import 'package:ble_inspector/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

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
