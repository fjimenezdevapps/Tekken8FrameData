import 'package:go_router/go_router.dart';
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
      builder: (context, state) {
        final characterName = state.extra as String;
        return FrameDataScreen(characterName: characterName);
      },
    ),
    GoRoute(
      path: '/move-details',
      name: DetailsCharacterMoveScreen.name,
      builder: (context, state) => const DetailsCharacterMoveScreen(),
    ),
  ],
);