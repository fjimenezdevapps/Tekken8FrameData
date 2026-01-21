import 'package:dio/dio.dart';
import '../models/character_frame_data.dart';
import '../exceptions/exceptions.dart';

class CharacterFrameDataRemoteDataSource {
  final Dio dio;

  CharacterFrameDataRemoteDataSource({required this.dio});

  Future<CharacterFrameData> getCharacterFrameData(String characterName) async {
    try {
      final response = await dio.get('/$characterName/framedata');

      if (response.statusCode == 200) {
        try {
          final data = response.data;
          return CharacterFrameData.fromJson(data);
        } catch (e) {
          throw MappingException('Error al parsear los datos del personaje: $e');
        }
      } else {
        throw ServerException(
          'Error al cargar la información del personaje',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const NetworkException('Tiempo de espera agotado. Verifica tu conexión a internet.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException('Error de conexión. Verifica tu conexión a internet.');
      } else if (e.response != null) {
        throw ServerException(
          'Error del servidor: ${e.message ?? "Error desconocido"}',
          statusCode: e.response?.statusCode,
        );
      } else {
        throw NetworkException('Error de red: ${e.message ?? "Error desconocido"}');
      }
    } on DataException {
      rethrow;
    } catch (e) {
      throw NetworkException('Error inesperado: $e');
    }
  }
}

