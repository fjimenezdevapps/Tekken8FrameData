import 'package:tekkenframadata/domain/entities/character_moves_video.dart';

class Character {
  final String name;
  final String apiName;
  final String weakSide;
  final List<CharacterMoveVideo> videoListMoves;

  const Character({
    required this.name,
    required this.apiName,
    required this.weakSide,
    required this.videoListMoves
  });

  Character copyWith({
    String? name,
    String? apiName,
    String? weakSide,
    List<CharacterMoveVideo>? videoListMoves
  }) {
    return Character(
      name: name ?? this.name,
      apiName: apiName ?? this.apiName,
      weakSide: weakSide ?? this.weakSide,
      videoListMoves : videoListMoves ?? this.videoListMoves
    );
  }
}