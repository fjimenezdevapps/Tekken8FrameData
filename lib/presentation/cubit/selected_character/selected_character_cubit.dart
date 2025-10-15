import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekkenframadata/domain/entities/character.dart';
import 'package:tekkenframadata/presentation/cubit/selected_character/selected_character_state.dart';

class SelectedCharacterCubit extends Cubit<SelectedCharacterState> {
  SelectedCharacterCubit() : super(SelectedCharacterState.initial());

  void selectCharacter(Character character) {
    emit(state.copyWith(character: character));
  }

  void clearSelection() {
    emit(SelectedCharacterState.initial());
  }
}
