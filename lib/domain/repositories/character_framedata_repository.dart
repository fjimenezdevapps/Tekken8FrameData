import 'package:tekkenframadata/domain/entities/character_frame_data.dart';

abstract class CharacterFrameDataRepository {
  Future<CharacterFrameData> getCharacterFrameData(String characterName);
}
