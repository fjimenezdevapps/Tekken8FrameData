import 'package:flutter/material.dart';

/// Card reutilizable con elevación, borde y gradiente sutil.
/// Diseñada para encajar con el look rojo/azul oscuro de la app.
class AppElevatedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double elevation;

  /// Si `true`, agrega un borde sutil para separar del background.
  final bool showBorder;

  /// Controla qué tan "sólida" se ve la card. Valores altos reducen transparencia
  /// (mejor para evitar mareo con backgrounds con gradiente).
  final double surfaceOpacity;

  const AppElevatedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.borderRadius = 16,
    this.elevation = 8,
    this.showBorder = true,
    this.surfaceOpacity = 0.94,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    // Colores alineados al theme actual (AppTheme).
    const primary = Color(0xFFB71C1C);
    const secondary = Color(0xFF1B263B);
    const tertiary = Color(0xFF0D1B2A);

    final clampedSurfaceOpacity = surfaceOpacity.clamp(0.0, 1.0);
    final bg = tertiary.withValues(alpha: clampedSurfaceOpacity);

    // Gradiente *opaco* (sin alpha), para evitar que se vea el fondo a través.
    final g1 = Color.lerp(tertiary, primary, 0.18)!;
    final g2 = Color.lerp(tertiary, secondary, 0.55)!;
    final g3 = tertiary;

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        elevation: elevation,
        shadowColor: Colors.black.withValues(alpha: 0.35),
        borderRadius: radius,
        child: ClipRRect(
          borderRadius: radius,
          child: Container(
            decoration: BoxDecoration(
              // Base sólida (reduce transparencia y “flicker” del gradiente de fondo).
              color: bg,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Un highlight rojo muy sutil + transición a superficies oscuras.
                  g1,
                  g2,
                  g3,
                ],
              ),
              borderRadius: radius,
              border: showBorder
                  ? Border.all(
                      color: Colors.white.withValues(alpha: 0.18),
                      width: 1,
                    )
                  : null,
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

