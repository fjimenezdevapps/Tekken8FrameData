import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tekkenframadata/domain/entities/character.dart';
import 'package:tekkenframadata/presentation/providers/character/selected_character_provider.dart';

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double slant = size.width * 0.1;
    path.moveTo(slant, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - slant, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ConteinerCharacter extends ConsumerWidget {
  final Character character;
  const ConteinerCharacter({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String iconPath(String avatarName) =>
        'assets/characters_avatar/${avatarName}_avatar_tekken8.jpg';
    final selectedCharacter = ref.watch(selectedCharacterProvider);

    return InkWell(
      onTap: () {
        if (selectedCharacter.apiName != '') {
          ref.read(selectedCharacterProvider.notifier).clear();
        }
        ref.read(selectedCharacterProvider.notifier).select(character);
        context.push('/frame-data', extra: character.apiName);
      },
      splashColor: Colors.white.withOpacity(0.5),
      child: Container(
        height: 70,
        color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconPath(character.apiName),
              width: 80,
              height: 70,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                character.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'MonsterBites',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
