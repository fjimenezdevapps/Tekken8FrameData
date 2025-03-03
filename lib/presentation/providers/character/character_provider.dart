import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tekkenframadata/data/datasource/local_character_datasource.dart';
import 'package:tekkenframadata/data/repositories/character_repository_impl.dart';
import 'package:tekkenframadata/domain/entities/character.dart';
import 'package:tekkenframadata/domain/usecase/characters/get_all_characters.dart';

part 'character_provider.g.dart';

final localCharacterDataSourceProvider =
    Provider<LocalCharacterDataSource>((ref) {
  return LocalCharacterDataSource();
});

final characterRepositoryProvider = Provider<CharacterRepositoryImpl>((ref) {
  final dataSource = ref.watch(localCharacterDataSourceProvider);
  return CharacterRepositoryImpl(dataSource);
});

final getAllCharactersUseCaseProvider = Provider<GetAllCharacters>((ref) {
  final repository = ref.watch(characterRepositoryProvider);
  return GetAllCharacters(repository);
});

@riverpod
class CharacterNotifier extends _$CharacterNotifier {
  @override
  FutureOr<List<Character>> build() async {
    final useCase = ref.read(getAllCharactersUseCaseProvider);
    return await useCase();
  }
}
