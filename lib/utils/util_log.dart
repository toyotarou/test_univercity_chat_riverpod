// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:developer';

import 'package:flutter/foundation.dart';

void utilLog(dynamic value, [bool forcedDisplay = false]) {
  if (kDebugMode && !forcedDisplay) {
    log(value.toString());
  }
}
