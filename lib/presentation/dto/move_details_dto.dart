import 'package:tekkenframadata/domain/entities/frame_data.dart';

/// DTO de presentación para navegar a la pantalla de detalles sin acoplar
/// la UI a entidades/modelos externos ni arrastrar data innecesaria.
class MoveDetailsDto {
  final int moveNumber;
  final String command;
  final String? name;
  final String hitLevel;
  final String damage;
  final String startup;
  final String block;
  final String hit;
  final String counterHit;
  final String notes;
  final String wavuId;
  final Map<String, String?>? tags;
  final String? recovery;

  const MoveDetailsDto({
    required this.moveNumber,
    required this.command,
    required this.name,
    required this.hitLevel,
    required this.damage,
    required this.startup,
    required this.block,
    required this.hit,
    required this.counterHit,
    required this.notes,
    required this.wavuId,
    this.tags,
    this.recovery,
  });

  factory MoveDetailsDto.fromFrameData(FrameData move) {
    return MoveDetailsDto(
      moveNumber: move.moveNumber,
      command: move.command,
      name: move.name,
      hitLevel: move.hitLevel,
      damage: move.damage,
      startup: move.startup,
      block: move.block,
      hit: move.hit,
      counterHit: move.counterHit,
      notes: move.notes,
      wavuId: move.wavuId,
      tags: move.tags,
      recovery: move.recovery,
    );
  }

  /// Necesario para serialización (p. ej. navigation/state restoration).
  Map<String, dynamic> toJson() {
    return {
      'moveNumber': moveNumber,
      'command': command,
      'name': name,
      'hitLevel': hitLevel,
      'damage': damage,
      'startup': startup,
      'block': block,
      'hit': hit,
      'counterHit': counterHit,
      'notes': notes,
      'wavuId': wavuId,
      'tags': tags,
      'recovery': recovery,
    };
  }

  factory MoveDetailsDto.fromJson(Map<String, dynamic> json) {
    final rawTags = json['tags'];
    Map<String, String?>? parsedTags;
    if (rawTags is Map) {
      parsedTags = rawTags.map(
        (key, value) => MapEntry(key.toString(), value?.toString()),
      );
    }

    return MoveDetailsDto(
      moveNumber: (json['moveNumber'] as num?)?.toInt() ?? 0,
      command: json['command']?.toString() ?? '',
      name: json['name']?.toString(),
      hitLevel: json['hitLevel']?.toString() ?? '',
      damage: json['damage']?.toString() ?? '',
      startup: json['startup']?.toString() ?? '',
      block: json['block']?.toString() ?? '',
      hit: json['hit']?.toString() ?? '',
      counterHit: json['counterHit']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      wavuId: json['wavuId']?.toString() ?? '',
      tags: parsedTags,
      recovery: json['recovery']?.toString(),
    );
  }
}
