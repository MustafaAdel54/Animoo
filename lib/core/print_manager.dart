import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class PrintManager {
  static final Logger _logger = Logger();

  static void printTrace(String message) {
    if (kDebugMode) _logger.t(message);
  }

  static void printDebug(String message) {
    if (kDebugMode) _logger.d(message);
  }

  static void printError(String message) {
    if (kDebugMode) _logger.e(message);
  }
}
