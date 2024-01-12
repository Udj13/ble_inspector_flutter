import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class SensorDescription extends StatelessWidget {
  const SensorDescription(
      {Key? key,
      required this.manufacturer,
      required this.sensorTitle,
      required this.sensorDescription,
      required this.url})
      : super(key: key);
  final String manufacturer;
  final String sensorTitle;
  final String sensorDescription;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                CupertinoIcons.doc_text,
                color: Styles.deviceDescriptionIconColor,
              ),
              const SizedBox(width: 5),
              Text(
                manufacturer,
                style: Styles.deviceParametrLabel,
              ),
              const SizedBox(width: 5),
              Text(
                sensorDescription,
                style: Styles.deviceDataLabel,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                sensorTitle,
                style: Styles.deviceDataText,
              ),
              CupertinoButton(
                onPressed: () async {
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                child: const Icon(CupertinoIcons.book),
                padding: const EdgeInsets.all(0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
