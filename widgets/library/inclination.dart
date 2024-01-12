import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Inclination extends StatelessWidget {
  const Inclination({Key? key, required this.level}) : super(key: key);
  final int level;

  @override
  Widget build(BuildContext context) {
    final radians = 2 * 3.14 * level / 360;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Transform.rotate(
                angle: radians,
                child: const Icon(
                  CupertinoIcons.rotate_right_fill,
                  color: Styles.inclinationDataIconColor,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.inclination,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              const Text(
                '°',
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            level.toString(),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}
