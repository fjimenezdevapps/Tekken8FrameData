import 'package:dio/dio.dart';
import '../models/character_frame_data.dart';

class CharacterFrameDataRemoteDataSource {
  final Dio _dio;

  CharacterFrameDataRemoteDataSource()
      : _dio = Dio(BaseOptions(baseUrl: 'https://tekkendocs.com/api/t8'));

  Future<CharacterFrameData> getCharacterFrameData(String characterName) async {
    try {
      final response = await _dio.get('/$characterName/framedata');

      if (response.statusCode == 200) {
        final data = response.data;

        return CharacterFrameData.fromJson(data);
      } else {
        throw Exception('Error al cargar la información del personaje: Código de estado ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    }
  }
}

