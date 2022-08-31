class KSException implements Exception {
  final String message;
  KSException({
    required this.message,
  });
}

class PlatformNotSupportedException extends KSException {
  PlatformNotSupportedException({super.message = 'Platform is not supported'});
}

class NotImplementedException extends KSException {
  NotImplementedException({super.message = 'Not implemented'});
}

class ConnectionIsCloseException extends KSException {
  ConnectionIsCloseException({super.message = 'Connection is close'});
}