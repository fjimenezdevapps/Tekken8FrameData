import 'package:tekkenframadata/domain/entities/frame_data.dart';

class CharacterFrameData {
  final String characterName;
  final String editUrl;
  final String game;
  final List<FrameData> framesNormal;
  final List<String> stances;

  const CharacterFrameData({
    required this.characterName,
    required this.editUrl,
    required this.game,
    required this.framesNormal,
    required this.stances,
  });
}
