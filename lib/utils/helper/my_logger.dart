import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger();

  static void d(dynamic message) => _logger.d(message);

  static void e(dynamic message) => _logger.e(message);

  static void i(dynamic message) => _logger.i(message);

  static void w(dynamic message) => _logger.w(message);

  static void v(dynamic message) => _logger.v(message);

  static void wtf(dynamic message) => _logger.wtf(message);
}
