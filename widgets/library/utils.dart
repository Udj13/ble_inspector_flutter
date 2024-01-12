import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../storage.dart';

const locale = 'ru';
const rowEdge = EdgeInsets.fromLTRB(0, 5, 15, 5);

class SaveAsDialog extends StatefulWidget {
  const SaveAsDialog({
    Key? key,
    required this.name,
    required this.mac,
  }) : super(key: key);

  final String name;
  final String mac;

  @override
  State<SaveAsDialog> createState() => _SaveAsDialogState();
}

class _SaveAsDialogState extends State<SaveAsDialog> {
  late TextEditingController _textController;
  String newValue = '';
  String sensorName = '';

  @override
  void initState() {
    loadName();
    _textController = TextEditingController(text: sensorName);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  loadName() async {
    sensorName = await GetSensorName(widget.mac);
    newValue = sensorName;
    _textController = TextEditingController(text: sensorName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.name),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.newLocalName,
            style: Styles.deviceDataLabel,
          ),
          CupertinoTextField(
            controller: _textController,
            textInputAction: TextInputAction.next,
            restorationId: AppLocalizations.of(context)!.newName,
            placeholder: sensorName,
            clearButtonMode: OverlayVisibilityMode.editing,
            autocorrect: false,
            onChanged: (value) {
              newValue = value;
            },
          ),
        ],
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text(AppLocalizations.of(context)!.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text(AppLocalizations.of(context)!.saveAs),
          isDestructiveAction: false,
          onPressed: () async {
            await SetSensorName(widget.mac, newValue);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class BIDevider extends StatelessWidget {
  const BIDevider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      thickness: 1,
      indent: 20,
      endIndent: 0,
      color: Styles.deviceRowDivider,
    );
  }
}
