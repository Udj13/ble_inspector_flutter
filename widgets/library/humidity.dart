import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

class Humidity extends StatelessWidget {
  const Humidity({Key? key, required this.level}) : super(key: key);
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
                level > 50 ? CupertinoIcons.drop_fill : CupertinoIcons.drop,
                color: level > 50
                    ? Styles.humidityIconColorHi
                    : Styles.humidityIconColorLow,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.humidity,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              const Text(
                "%",
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
