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
}
