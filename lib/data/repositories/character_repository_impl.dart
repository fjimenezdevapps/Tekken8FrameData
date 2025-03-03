import 'package:tekkenframadata/data/datasource/local_character_datasource.dart';
import 'package:tekkenframadata/domain/entities/character.dart';
import 'package:tekkenframadata/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final LocalCharacterDataSource localDataSource;

  CharacterRepositoryImpl(this.localDataSource);

  @override
  Future<List<Character>> getAllCharacters() async {
    return Future.value(localDataSource.getCharacters());
  }
}
