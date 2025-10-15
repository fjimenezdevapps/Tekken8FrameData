import 'package:equatable/equatable.dart';
import 'package:tekkenframadata/data/models/character_frame_data.dart';

abstract class CharacterFrameDataState extends Equatable {
  const CharacterFrameDataState();

  @override
  List<Object?> get props => [];
}

class CharacterFrameDataInitial extends CharacterFrameDataState {}

class CharacterFrameDataLoading extends CharacterFrameDataState {}

class CharacterFrameDataLoaded extends CharacterFrameDataState {
  final CharacterFrameData frameData;

  const CharacterFrameDataLoaded({required this.frameData});

  @override
  List<Object?> get props => [frameData];
}

class CharacterFrameDataError extends CharacterFrameDataState {
  final String message;

  const CharacterFrameDataError({required this.message});

  @override
  List<Object?> get props => [message];
}
