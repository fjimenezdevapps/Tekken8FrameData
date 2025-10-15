import 'package:tekkenframadata/data/models/character_frame_data.dart';
import 'package:tekkenframadata/domain/repositories/character_framedata_repository.dart';

class GetCharacterFrameDataUseCase {
  final CharacterFrameDataRepository repository;

  GetCharacterFrameDataUseCase(this.repository);

  Future<CharacterFrameData> call(String name) async {
    return repository.getCharacterFrameData(name);
  }
}