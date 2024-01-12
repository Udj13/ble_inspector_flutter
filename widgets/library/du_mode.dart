import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utils.dart';

class DUMode extends StatelessWidget {
  const DUMode({Key? key, required this.mode}) : super(key: key);
  final int mode;

  String modeStringFromCode(BuildContext context, int mode) {
    if (mode == 5) {
      return AppLocalizations.of(context)!.horizontalRotation;
    }
    if (mode == 4) {
      return AppLocalizations.of(context)!.verticalRotation;
    }
    if (mode == 9) {
      return AppLocalizations.of(context)!.bucket;
    }
    if (mode == 10) {
      return AppLocalizations.of(context)!.plow;
    }
    if (mode == 6) {
      return AppLocalizations.of(context)!.angleControl;
    }
    if (mode == 11) {
      return AppLocalizations.of(context)!.horizontalAngle;
    }
    if (mode == 12) {
      return AppLocalizations.of(context)!.verticalAngle;
    }
    if (mode == 7) {
      return AppLocalizations.of(context)!.container;
    }
    if (mode == 0) {
      return AppLocalizations.of(context)!.disabled;
    }

    return "";
  }

  String modeStatusFromCode(BuildContext context, int mode) {
    if (mode != 0) {
      return AppLocalizations.of(context)!.active;
    }
    return AppLocalizations.of(context)!.transportation;
  }

  IconData getModeIcon(int degrees) {
    if (mode == 0) return CupertinoIcons.clear_circled_solid;
    return CupertinoIcons.option;
  }

  Color getModIconColor(int degrees) {
    if (mode == 0) return Styles.temperatureIconColorHi;
    return Styles.temperatureIconColorLow;
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
                getModeIcon(mode),
                color: getModIconColor(mode),
              ),
              SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.mode,
                style: Styles.deviceParametrLabel,
              ),
              SizedBox(width: 5),
              Text(
                modeStringFromCode(context, mode),
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            modeStatusFromCode(context, mode),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}
