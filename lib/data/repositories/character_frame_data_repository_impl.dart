import '../../domain/entities/character_frame_data.dart';
import '../../domain/repositories/character_framedata_repository.dart';
import '../datasource/character_frame_data_remote_datasource.dart';

class CharacterFrameDataRepositoryImpl implements CharacterFrameDataRepository {
  final CharacterFrameDataRemoteDataSource remoteDataSource;

  CharacterFrameDataRepositoryImpl(this.remoteDataSource);

  @override
  Future<CharacterFrameData> getCharacterFrameData(String characterName) async {
    return await remoteDataSource.getCharacterFrameData(characterName);
  }
}
