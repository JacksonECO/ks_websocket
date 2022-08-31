ksLog(dynamic message, {String? name}) => KsLogConfig.log(message, name: name);

class KsLogConfig {
  /// if false, log will be printed to console
  static bool isProduction = true;

  /// variable static to print log
  static void Function(dynamic message, {String? name}) log = _logDefault;

  static void _logDefault(dynamic message, {String? name}) {
    if (isProduction) return;

    print('${name ?? 'KsLog'}: $message');
  }

  static defaultStatic() {
    isProduction = true;
    log = _logDefault;
  }
}
