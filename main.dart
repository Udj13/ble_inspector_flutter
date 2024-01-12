import 'package:flutter/cupertino.dart';
import 'app.dart';

void main() {
// async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await MobileAds.instance.initialize().then((InitializationStatus status) {
//     print('Initialization done: ${status.adapterStatuses}');
//     MobileAds.instance.updateRequestConfiguration(
//       RequestConfiguration(
//           tagForChildDirectedTreatment:
//               TagForChildDirectedTreatment.unspecified,
//           testDeviceIds: <String>["2AD9A5566358A47A6FB25BD7BFD3105C"]),
//     );
//   });
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();

  return runApp(const BLEInspectorApp());
}
