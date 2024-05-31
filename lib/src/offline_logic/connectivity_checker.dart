// Flutter imports:
import 'package:aptabase_flutter/src/offline_logic/connectivity_checker_webless.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';

Future<bool> get isConnected async {
  try {
    final results = await Connectivity().checkConnectivity();
    if (kIsWeb) {
      if (results.any((e) =>
          e == ConnectivityResult.wifi ||
          e == ConnectivityResult.ethernet ||
          e == ConnectivityResult.bluetooth)) {
        return true;
      } else {
        return false;
      }
    } else {
      return await isInternetAvailable(results);
    }
  } on PlatformException catch (e) {
    developer.log(e.toString());
    return false;
  }
}
