import 'package:flutter/material.dart';
import 'package:tekkenframadata/config/utils/characters_tekken_list.dart';
import 'package:tekkenframadata/presentation/widgets/characters/character_card.dart';

class CharacterSelectionScreen extends StatelessWidget {
  static const String name = 'character-selection';
  
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character selection'),
        centerTitle: true,
        elevation: 0,
      ),
      body: const _CharacterSelectionView(),
    );
  }
}

class _CharacterSelectionView extends StatelessWidget {
  const _CharacterSelectionView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(18.0),
        itemCount: (tekkenCharacters.length / 2).ceil(),
        itemBuilder: (context, rowIndex) {
          int firstItemIndex = rowIndex * 2;
          int secondItemIndex = firstItemIndex + 1;
          
          // Si solo queda un botón
          if (firstItemIndex < tekkenCharacters.length && secondItemIndex >= tekkenCharacters.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildSkewedSpecialButton(context, tekkenCharacters[firstItemIndex]),
                ],
              ),
            );
          }
          
          // Fila con dos botones
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: buildSkewedButton(context, tekkenCharacters[firstItemIndex])),
                const SizedBox(width: 16.0),
                Expanded(child: buildSkewedButton(context, tekkenCharacters[secondItemIndex])),
              ],
            ),
          );
        },
      );
  }
}
