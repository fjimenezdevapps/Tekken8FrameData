import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekkenframadata/presentation/cubit/character/character_cubit.dart';
import 'package:tekkenframadata/presentation/cubit/character/character_state.dart';
import 'package:tekkenframadata/presentation/widgets/characters/character_card.dart';

class CharacterSelectionScreen extends StatelessWidget {
  static const String name = 'character-selection';
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load characters when screen is built
    context.read<CharacterCubit>().loadCharacters();

    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Character Selection',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'MonsterBites',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              iconTheme: const IconThemeData(color: Colors.white)),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFB71C1C),
                  Color(0xFF1B263B),
                  Color(0xFF0D1B2A),
                ],
              ),
            ),
            child: SafeArea(
              child: _buildCharacterList(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCharacterList(CharacterState state) {
    if (state is CharacterLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CharacterError) {
      return Center(child: Text('Error: ${state.message}'));
    } else if (state is CharacterLoaded) {
      final characters = state.characters;
      return ListView.builder(
        padding: const EdgeInsets.all(4.0),
        itemCount: (characters.length / 2).ceil(),
        itemBuilder: (context, rowIndex) {
          int firstItemIndex = rowIndex * 2;
          int secondItemIndex = firstItemIndex + 1;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double buttonWidth = (constraints.maxWidth - 16) / 2;
                return Row(
                  children: [
                    SizedBox(
                      width: buttonWidth,
                      child: ClipPath(
                        clipper: ParallelogramClipper(),
                        child: ConteinerCharacter(
                          character: characters[firstItemIndex],
                        ),
                      ),
                    ),
                    if (secondItemIndex < characters.length) ...[
                      const SizedBox(width: 12.0),
                      SizedBox(
                        width: buttonWidth,
                        child: ClipPath(
                          clipper: ParallelogramClipper(),
                          child: ConteinerCharacter(
                            character: characters[secondItemIndex],
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
