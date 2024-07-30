class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class InvalidResponseException extends ApiException {
  InvalidResponseException(super.message);
}

class UnexpectedException extends ApiException {
  UnexpectedException(super.message);
}
