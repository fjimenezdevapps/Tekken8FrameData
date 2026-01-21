/// Excepción base para errores de la capa de datos
abstract class DataException implements Exception {
  final String message;
  const DataException(this.message);
  
  @override
  String toString() => message;
}

/// Excepción para errores de red
class NetworkException extends DataException {
  const NetworkException(super.message);
}

/// Excepción para errores de servidor
class ServerException extends DataException {
  final int? statusCode;
  const ServerException(super.message, {this.statusCode});
  
  @override
  String toString() => statusCode != null 
      ? '$message (Status Code: $statusCode)'
      : message;
}

/// Excepción para errores de mapeo de datos
class MappingException extends DataException {
  const MappingException(super.message);
}

/// Excepción para errores de datos locales
class LocalDataException extends DataException {
  const LocalDataException(super.message);
}
