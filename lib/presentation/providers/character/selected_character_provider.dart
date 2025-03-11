import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tekkenframadata/domain/entities/character.dart';

part 'selected_character_provider.g.dart';

@riverpod
class SelectedCharacter extends _$SelectedCharacter {
  @override
  Character build() =>
      const Character(name: '', apiName: '', weakSide: '', videoListMoves: []); // Valor por defecto

  // Método para seleccionar un personaje
  void select(Character character) {
    state = character;
  }

  // Método para limpiar la selección utilizando copyWith
  void clear() {
    state = state.copyWith(name: '', apiName: '', weakSide: '', videoListMoves: []);
  }
}