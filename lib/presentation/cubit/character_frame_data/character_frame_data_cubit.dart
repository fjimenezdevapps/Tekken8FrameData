import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekkenframadata/data/datasource/character_frame_data_remote_datasource.dart';
import 'package:tekkenframadata/data/repositories/character_frame_data_repository_impl.dart';
import 'package:tekkenframadata/domain/usecase/moves/get_character_framedata_usecase.dart';
import 'package:tekkenframadata/presentation/cubit/character_frame_data/character_frame_data_state.dart';

class CharacterFrameDataCubit extends Cubit<CharacterFrameDataState> {
  final GetCharacterFrameDataUseCase _getCharacterFrameDataUseCase;

  CharacterFrameDataCubit({required GetCharacterFrameDataUseCase getCharacterFrameDataUseCase})
      : _getCharacterFrameDataUseCase = getCharacterFrameDataUseCase,
        super(CharacterFrameDataInitial());

  static CharacterFrameDataCubit create() {
    final dio = Dio(BaseOptions(baseUrl: 'https://tekkendocs.com/api/t8'));
    final remoteDataSource = CharacterFrameDataRemoteDataSource(dio: dio);
    final repository = CharacterFrameDataRepositoryImpl(remoteDataSource);
    final useCase = GetCharacterFrameDataUseCase(repository);
    return CharacterFrameDataCubit(getCharacterFrameDataUseCase: useCase);
  }

  Future<void> loadFrameData(String characterName) async {
    emit(CharacterFrameDataLoading());
    try {
      final frameData = await _getCharacterFrameDataUseCase(characterName);
      emit(CharacterFrameDataLoaded(frameData: frameData));
    } catch (e) {
      emit(CharacterFrameDataError(message: e.toString()));
    }
  }
}
