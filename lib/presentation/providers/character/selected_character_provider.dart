import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tekkenframadata/domain/entities/character.dart';

part 'selected_character_provider.g.dart';

@riverpod
class SelectedCharacter extends _$SelectedCharacter {
  @override
  Character build() =>
      const Character(name: '', apiName: '', weakSide: '', videoListMoves: []);

  void select(Character character) {
    state = character;
  }

  void clear() {
    state = state.copyWith(name: '', apiName: '', weakSide: '', videoListMoves: []);
  }
}