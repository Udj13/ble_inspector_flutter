import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

class Illumination extends StatelessWidget {
  const Illumination({Key? key, required this.level}) : super(key: key);
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
                level > 100
                    ? CupertinoIcons.brightness_solid
                    : CupertinoIcons.moon_fill,
                color: level > 100
                    ? Styles.illuminationIconColorHi
                    : Styles.illuminationIconColorLow,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.illumination,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.lux,
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
