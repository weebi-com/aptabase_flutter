// Flutter imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

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
      return await _isInternetAvailable(results);
    }
  } on PlatformException catch (e) {
    developer.log(e.toString());
    return false;
  }
}

Future<bool> _isInternetAvailable(List<ConnectivityResult> results) async {
  if (results.first == ConnectivityResult.none) {
    return false;
  } else {
    return await InternetConnection().hasInternetAccess;
  }
}

