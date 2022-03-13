import 'package:ble_inspector/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'admob.dart';
import 'screens.dart';
import 'model.dart';
import 'demo_widgets.dart';

class BLEInspectorApp extends StatelessWidget {
  const BLEInspectorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
        title: 'BLE Inspector',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
          Locale('ru', ''), // Russian, no country code
        ],
        theme: const CupertinoThemeData(brightness: Brightness.light),
        home: StreamBuilder<BluetoothState>(
            stream: FlutterBlue.instance.state,
            initialData: BluetoothState.unknown,
            builder: (c, snapshot) {
              final state = snapshot.data;
              if (state == BluetoothState.on) {
                return const CupertinoBLEInspectorHomePage();
              }
//              return const CupertinoBLEInspectorHomePage(); // debug
              return CupertinoBluetoothOffPage(state: state);
            }));
  }
}

class CupertinoBLEInspectorHomePage extends StatefulWidget {
  const CupertinoBLEInspectorHomePage({Key? key}) : super(key: key);

  @override
  State<CupertinoBLEInspectorHomePage> createState() =>
      _CupertinoBLEInspectorHomePageState();
}

class _CupertinoBLEInspectorHomePageState
    extends State<CupertinoBLEInspectorHomePage> {
  late Container adContainer;

  @override
  void initState() {
    adContainer = LoadAdmob();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Styles.scaffoldBackground,
        navigationBar: CupertinoNavigationBar(
          middle: StreamBuilder<bool>(
            stream: FlutterBlue.instance.isScanning,
            initialData: false,
            builder: (c, snapshot) {
              if (snapshot.data!) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CupertinoActivityIndicator(),
                    SizedBox(
                      width: 5,
                    ),
                    Text(AppLocalizations.of(context)!.scanning),
                  ],
                );
              } else {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(AppLocalizations.of(context)!.bleInspector),
                    ]);
              }
            },
          ),
          trailing: StreamBuilder<bool>(
            stream: FlutterBlue.instance.isScanning,
            initialData: false,
            builder: (c, snapshot) {
              if (snapshot.data!) {
                return CupertinoButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  onPressed: () => FlutterBlue.instance.stopScan(),
                  child: const Icon(
                    CupertinoIcons.arrow_2_circlepath_circle_fill,
                    color: Styles.batteryIconColorLow,
                  ),
                );
              } else {
                return CupertinoButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  onPressed: () => FlutterBlue.instance
                      .startScan(timeout: const Duration(seconds: 5)),
                  child: const Icon(CupertinoIcons.arrow_2_circlepath_circle),
                );
              }
            },
          ),
        ),
        child: SafeArea(
            child: Stack(children: [
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder<List<ScanResult>>(
                      stream: FlutterBlue.instance.scanResults,
                      initialData: [],
                      builder: (c, snapshot) => Column(
                          children: snapshot.data!
                              .map((r) => ScanResultTile(result: r))
                              .toList()),
                    ),
                  ])),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: adContainer,
          ),
        ])));
  }
}

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    print(result.advertisementData.localName);
    print(result.device.name);
    print(result.device.id);

    Widget? newWidget =
        GetSensor(result.advertisementData, result.device.id.toString());
    if (newWidget != null)
      return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 700),
          builder: (BuildContext context, double tween, Widget? child) {
            return Transform.translate(
              offset: Offset(0, 20 - tween * 20),
              child: Opacity(
                opacity: tween,
                child: newWidget,
              ),
            );
          });

    return const SizedBox.shrink();
  }
}
