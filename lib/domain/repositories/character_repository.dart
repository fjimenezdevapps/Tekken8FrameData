import 'package:tekkenframadata/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getAllCharacters();
}
