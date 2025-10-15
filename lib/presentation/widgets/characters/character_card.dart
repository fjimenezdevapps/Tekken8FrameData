import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekkenframadata/domain/entities/character.dart';
import 'package:tekkenframadata/presentation/cubit/selected_character/selected_character_cubit.dart';
import 'package:tekkenframadata/presentation/cubit/selected_character/selected_character_state.dart';

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

class ConteinerCharacter extends StatelessWidget {
  final Character character;
  const ConteinerCharacter({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    String iconPath(String avatarName) =>
        'assets/characters_avatar/${avatarName}_avatar_tekken8.jpg';

    return BlocBuilder<SelectedCharacterCubit, SelectedCharacterState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state.character.apiName != '') {
              context.read<SelectedCharacterCubit>().clearSelection();
            }
            context.read<SelectedCharacterCubit>().selectCharacter(character);
            context.push('/frame-data', extra: character.apiName);
          },
          splashColor: Colors.white.withValues(alpha: 0.5),
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
      },
    );
  }
}
