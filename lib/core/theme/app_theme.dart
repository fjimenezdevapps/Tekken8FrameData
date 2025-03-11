import 'package:flutter/material.dart';

class AppTheme {
  
  final Color primaryColor = const Color(0xFFB71C1C);
  final Color secondaryColor = const Color(0xFF1B263B);
  final Color tertiaryColor = const Color(0xFF0D1B2A);

  List<Color> get gradientColors =>
      [primaryColor, secondaryColor, tertiaryColor];

  
  Gradient get backgroundGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradientColors,
      );

  ThemeData getTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: tertiaryColor,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'MonsterBites',
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}


class AppBackground extends StatelessWidget {
  final Widget child;
  final AppTheme appTheme;

  const AppBackground({
    super.key,
    required this.child,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: appTheme.backgroundGradient,
      ),
      child: child,
    );
  }
}
