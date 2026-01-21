import '../../domain/entities/character_frame_data.dart';
import '../../domain/repositories/character_framedata_repository.dart';
import '../datasource/character_frame_data_remote_datasource.dart';
import '../mappers/character_frame_data_mapper.dart';
import '../exceptions/exceptions.dart';

class CharacterFrameDataRepositoryImpl implements CharacterFrameDataRepository {
  final CharacterFrameDataRemoteDataSource remoteDataSource;

  CharacterFrameDataRepositoryImpl(this.remoteDataSource);

  @override
  Future<CharacterFrameData> getCharacterFrameData(String characterName) async {
    try {
      final model = await remoteDataSource.getCharacterFrameData(characterName);
      return CharacterFrameDataMapper.toEntity(model);
    } on DataException {
      rethrow;
    } catch (e) {
      throw MappingException('Error al mapear los datos del personaje: $e');
    }
  }
}
