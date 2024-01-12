import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utils.dart';

class Temperature extends StatelessWidget {
  const Temperature({Key? key, required this.degrees}) : super(key: key);
  final int degrees;

  IconData _getTemperatureIcon(int degrees) {
    if (degrees > 25) return CupertinoIcons.thermometer_sun;
    if (degrees < -5) return CupertinoIcons.thermometer_snowflake;
    return CupertinoIcons.thermometer;
  }

  Color _getTemperatureIconColor(int degrees) {
    if (degrees > 25) return Styles.temperatureIconColorHi;
    if (degrees < -5) return Styles.temperatureIconColorLow;
    return Styles.temperatureIconColorNormal;
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
                _getTemperatureIcon(degrees),
                color: _getTemperatureIconColor(degrees),
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.temperature,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              const Text(
                '°C',
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Text(
            degrees.toString(),
            style: Styles.deviceDataText,
          ),
        ],
      ),
    );
  }
}
