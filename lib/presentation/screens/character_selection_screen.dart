import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekkenframadata/presentation/providers/character/character_provider.dart';
import 'package:tekkenframadata/presentation/widgets/characters/character_card.dart';

class CharacterSelectionScreen extends ConsumerWidget {
  static const String name = 'character-selection';
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersAsyncValue = ref.watch(characterNotifierProvider);

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
        child: Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: charactersAsyncValue.when(
            data: (characters) => ListView.builder(
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
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ),
      ),
    );
  }
}
