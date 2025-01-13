import 'package:tekkenframadata/domain/entities/character_frame_data.dart';

abstract class FrameDataRepository {
  Future<CharacterFrameData> getCharacterFrameData(String characterName);
}
