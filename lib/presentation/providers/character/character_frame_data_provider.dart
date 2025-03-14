import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tekkenframadata/data/datasource/character_frame_data_remote_datasource.dart';
import 'package:tekkenframadata/data/repositories/character_frame_data_repository_impl.dart';
import 'package:tekkenframadata/domain/entities/character_frame_data.dart';
import 'package:tekkenframadata/domain/repositories/character_framedata_repository.dart';
import 'package:tekkenframadata/domain/usecase/moves/get_character_framedata_usecase.dart';

part 'character_frame_data_provider.g.dart';


@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio();
}


@Riverpod(keepAlive: true)
CharacterFrameDataRemoteDataSource remoteDataSource(Ref ref) {
  return CharacterFrameDataRemoteDataSource();
}


@Riverpod(keepAlive: true)
CharacterFrameDataRepository characterFrameDataRepository(Ref ref) {
  final remoteDS = ref.watch(remoteDataSourceProvider);
  return CharacterFrameDataRepositoryImpl(remoteDS);
}

@Riverpod(keepAlive: true)
Future<CharacterFrameData> characterFrameData(
  Ref ref,
  String characterName,
) async {
  final repository = ref.watch(characterFrameDataRepositoryProvider);
  final useCase = GetCharacterFrameDataUseCase(repository);
  return useCase(characterName);
}
