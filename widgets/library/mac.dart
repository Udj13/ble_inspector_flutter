import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MAC extends StatelessWidget {
  const MAC({Key? key, required this.mac}) : super(key: key);
  final String mac;

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                CupertinoIcons.link,
                color: Styles.macIconColor,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.mac,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              Text(
                mac,
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Tooltip(
                message: AppLocalizations.of(context)!.copied,
                key: key,
                showDuration: Duration(seconds: 2),
                child: CupertinoButton(
                  onPressed: () {
                    final dynamic tooltip = key.currentState;
                    tooltip.ensureTooltipVisible();

                    ClipboardData clipboardData = ClipboardData(text: mac);
                    Clipboard.setData(clipboardData);
                  },
                  padding: const EdgeInsets.all(0),
                  child: const Icon(Icons.copy),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
