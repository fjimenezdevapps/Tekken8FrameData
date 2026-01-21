import 'package:flutter/material.dart';
import 'package:tekkenframadata/presentation/widgets/commons/elevated_card.dart';

/// Dialog base reutilizable para la app.
/// - Encaja con el background gradient (rojo/azul oscuro).
/// - Header opcional con título + botón de cerrar.
/// - Body y acciones totalmente customizables.
class AppDialog extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget body;
  final List<Widget> actions;
  final bool showCloseButton;
  final EdgeInsets insetPadding;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry bodyPadding;
  final EdgeInsetsGeometry actionsPadding;
  final double maxWidth;
  final double maxHeightFactor;

  const AppDialog({
    super.key,
    required this.body,
    this.title,
    this.titleWidget,
    this.actions = const [],
    this.showCloseButton = true,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    this.headerPadding = const EdgeInsets.fromLTRB(18, 16, 10, 8),
    this.bodyPadding = const EdgeInsets.fromLTRB(18, 8, 18, 18),
    this.actionsPadding = const EdgeInsets.fromLTRB(18, 0, 18, 14),
    this.maxWidth = 560,
    this.maxHeightFactor = 0.82,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: insetPadding,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: size.height * maxHeightFactor,
        ),
        child: AppElevatedCard(
          padding: EdgeInsets.zero,
          elevation: 14,
          borderRadius: 18,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null || titleWidget != null || showCloseButton)
                Padding(
                  padding: headerPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: titleWidget ??
                            Text(
                              title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'MonsterBites',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                      ),
                      if (showCloseButton)
                        IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          tooltip: 'Close',
                          icon: const Icon(Icons.close_rounded, color: Colors.white),
                        ),
                    ],
                  ),
                ),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 14),
                color: Colors.white.withValues(alpha: 0.10),
              ),
              Expanded(
                child: Padding(
                  padding: bodyPadding,
                  child: body,
                ),
              ),
              if (actions.isNotEmpty) ...[
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                Padding(
                  padding: actionsPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

