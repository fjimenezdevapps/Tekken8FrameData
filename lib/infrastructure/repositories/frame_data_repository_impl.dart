import '../../domain/entities/character_frame_data.dart';
import '../../domain/repositories/frame_data_repository.dart';
import '../datasource/frame_data_remote_datasource.dart';

class FrameDataRepositoryImpl implements FrameDataRepository {
  final FrameDataRemoteDataSource remoteDataSource;

  FrameDataRepositoryImpl(this.remoteDataSource);

  @override
  Future<CharacterFrameData> getCharacterFrameData(String characterName) async {
    return await remoteDataSource.getCharacterFrameData(characterName);
  }
}
