import 'package:tekkenframadata/domain/entities/character.dart';
import 'package:tekkenframadata/domain/repositories/character_repository.dart';

class GetAllCharacters {
  final CharacterRepository repository;

  GetAllCharacters(this.repository);

  Future<List<Character>> call() async {
    return await repository.getAllCharacters();
  }
}
