import 'package:equatable/equatable.dart';
import 'package:tekkenframadata/domain/entities/character.dart';

class SelectedCharacterState extends Equatable {
  final Character character;

  const SelectedCharacterState({required this.character});

  factory SelectedCharacterState.initial() {
    return const SelectedCharacterState(
      character: Character(
        name: '',
        apiName: '',
        weakSide: '',
      ),
    );
  }

  SelectedCharacterState copyWith({Character? character}) {
    return SelectedCharacterState(
      character: character ?? this.character,
    );
  }

  @override
  List<Object?> get props => [character];
}
