import 'package:tekkenframadata/data/models/character_frame_data.dart';

abstract class CharacterFrameDataRepository {
  Future<CharacterFrameData> getCharacterFrameData(String characterName);
}
