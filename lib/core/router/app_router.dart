import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekkenframadata/data/models/character_frame_data.dart';
import 'package:tekkenframadata/presentation/screens/character_selection_screen.dart';
import 'package:tekkenframadata/presentation/screens/details_character_move_screen.dart';
import 'package:tekkenframadata/presentation/screens/frame_data_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: CharacterSelectionScreen.name,
      builder: (context, state) => const CharacterSelectionScreen(),
    ),
    GoRoute(
      path: '/frame-data',
      name: FrameDataScreen.name,
      builder: (context, state) => const FrameDataScreen(),
    ),
    GoRoute(
      path: '/move-details',
      name: DetailsCharacterMoveScreen.name,
      pageBuilder: (context, state) {
        final move = state.extra as FramesNormal;
        return CustomTransitionPage(
          key: state.pageKey,
          child: DetailsCharacterMoveScreen(move: move),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
  ],
);
