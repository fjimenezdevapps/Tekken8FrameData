import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  final String name;
  const ConteinerCharacter({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    String iconPath(String avatarName) =>
        'assets/characters_avatar/${avatarName}_avatar_tekken8.jpg';

    return InkWell(
      onTap: () {
        context.push('/frame-data', extra: name);
      },
      splashColor: Colors.white.withOpacity(0.5),
      child: Container(
        height: 70,
        color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconPath(name),
              width: 80,
              height: 70,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                name.toUpperCase(),
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
