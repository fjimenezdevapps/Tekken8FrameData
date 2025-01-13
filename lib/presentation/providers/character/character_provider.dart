import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekkenframadata/domain/entities/character_frame_data.dart';
import 'character_repository_provider.dart';

final characterFrameDataProvider = FutureProvider.family<CharacterFrameData, String>((ref, characterName) async {
  final repository = ref.watch(frameDataRepositoryProvider);
  return await repository.getCharacterFrameData(characterName);
});