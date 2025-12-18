// exceptions/network_exceptions.dart
abstract class AppException implements Exception {
  final String message;
  final int? code;
  AppException(this.message, {this.code});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class BusinessException extends AppException {
   BusinessException(super.message,{super.code});
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message);
}

class ServerException extends AppException {
  ServerException(super.message);
}
class PermissionDeniedException extends AppException {
  PermissionDeniedException(super.message);
}
class NotFoundException extends AppException {
  NotFoundException(super.message);
}
