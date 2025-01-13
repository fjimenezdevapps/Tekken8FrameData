import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekkenframadata/domain/repositories/frame_data_repository.dart';
import 'package:tekkenframadata/infrastructure/datasource/frame_data_remote_datasource.dart';
import 'package:tekkenframadata/infrastructure/repositories/frame_data_repository_impl.dart';

final frameDataRepositoryProvider = Provider<FrameDataRepository>((ref) {
  final remoteDataSource = FrameDataRemoteDataSource();
  return FrameDataRepositoryImpl(remoteDataSource);
});