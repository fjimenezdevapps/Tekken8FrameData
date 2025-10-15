import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekkenframadata/core/router/app_router.dart';
import 'package:tekkenframadata/presentation/cubit/character/character_cubit.dart';
import 'package:tekkenframadata/presentation/cubit/selected_character/selected_character_cubit.dart';
import 'package:tekkenframadata/presentation/cubit/character_frame_data/character_frame_data_cubit.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppTheme appTheme = AppTheme();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterCubit>(
          create: (context) => CharacterCubit.create(),
        ),
        BlocProvider<SelectedCharacterCubit>(
          create: (context) => SelectedCharacterCubit(),
        ),
        BlocProvider<CharacterFrameDataCubit>(
          create: (context) => CharacterFrameDataCubit.create(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'Tekken 8 Frame Data',
        theme: appTheme.getTheme(),
      ),
    );
  }
}