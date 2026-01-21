import '../models/character_frame_data.dart' as model;
import '../../domain/entities/character_frame_data.dart' as entity;
import '../../domain/entities/frame_data.dart';

/// Mapper para convertir entre el modelo de datos y la entidad de dominio
class CharacterFrameDataMapper {
  /// Convierte un modelo de datos a una entidad de dominio
  static entity.CharacterFrameData toEntity(model.CharacterFrameData model) {
    return entity.CharacterFrameData(
      characterName: model.characterName,
      editUrl: model.editUrl,
      game: model.game,
      framesNormal: model.framesNormal.map((frame) => _frameToEntity(frame)).toList(),
      stances: List<String>.from(model.stances),
    );
  }

  /// Convierte una entidad de dominio a un modelo de datos
  static model.CharacterFrameData toModel(entity.CharacterFrameData entity) {
    return model.CharacterFrameData(
      characterName: entity.characterName,
      editUrl: entity.editUrl,
      game: entity.game,
      framesNormal: entity.framesNormal.map((frame) => _frameToModel(frame)).toList(),
      stances: List<String>.from(entity.stances),
    );
  }

  static FrameData _frameToEntity(model.FramesNormal frame) {
    return FrameData(
      moveNumber: frame.moveNumber,
      command: frame.command,
      name: frame.name,
      hitLevel: frame.hitLevel,
      damage: frame.damage,
      startup: frame.startup,
      block: frame.block,
      hit: frame.hit,
      counterHit: frame.counterHit,
      notes: frame.notes,
      wavuId: frame.wavuId,
      tags: frame.tags?.values,
      recovery: frame.recovery,
    );
  }

  static model.FramesNormal _frameToModel(FrameData frame) {
    return model.FramesNormal(
      moveNumber: frame.moveNumber,
      command: frame.command,
      name: frame.name,
      hitLevel: frame.hitLevel,
      damage: frame.damage,
      startup: frame.startup,
      block: frame.block,
      hit: frame.hit,
      counterHit: frame.counterHit,
      notes: frame.notes,
      wavuId: frame.wavuId,
      tags: frame.tags != null ? model.Tags(values: frame.tags!) : null,
      recovery: frame.recovery,
    );
  }
}
