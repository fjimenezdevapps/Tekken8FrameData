import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekkenframadata/data/datasource/local_character_datasource.dart';
import 'package:tekkenframadata/data/repositories/character_repository_impl.dart';
import 'package:tekkenframadata/domain/usecase/characters/get_all_characters.dart';
import 'package:tekkenframadata/presentation/cubit/character/character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetAllCharacters _getAllCharacters;

  CharacterCubit({required GetAllCharacters getAllCharacters})
      : _getAllCharacters = getAllCharacters,
        super(CharacterInitial());

  static CharacterCubit create() {
    final dataSource = LocalCharacterDataSource();
    final repository = CharacterRepositoryImpl(dataSource);
    final useCase = GetAllCharacters(repository);
    return CharacterCubit(getAllCharacters: useCase);
  }

  Future<void> loadCharacters() async {
    emit(CharacterLoading());
    try {
      final characters = await _getAllCharacters();
      emit(CharacterLoaded(characters: characters));
    } catch (e) {
      emit(CharacterError(message: e.toString()));
    }
  }
}
