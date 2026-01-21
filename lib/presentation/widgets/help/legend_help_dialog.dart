import 'package:flutter/material.dart';
import 'package:tekkenframadata/core/utils/moves_properties_legends.dart';
import 'package:tekkenframadata/presentation/widgets/commons/app_dialog.dart';

class HelpDialogWidget extends StatelessWidget {
  const HelpDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFB71C1C);
    // Acento claro para que los íconos/textos no “se pierdan” sobre fondos oscuros.
    const propertiesAccent = Color(0xFF4FC3F7);

    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isLandscape = size.width > size.height;
    
 
    final textScaleFactor = MediaQuery.textScalerOf(context).scale(1);
    final paddingScale = isSmallScreen ? 0.8 : 1.0;

    return DefaultTabController(
      length: 2,
      child: AppDialog(
        title: 'Move Notation Guide',
        // Permitimos más ancho en landscape/tablet sin romper móviles.
        maxWidth: isLandscape ? 680 : 560,
        bodyPadding: EdgeInsets.zero,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.10),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  color: primary.withValues(alpha: 0.95),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: (isSmallScreen ? 13 : 14) * textScaleFactor,
                  letterSpacing: 0.2,
                ),
                unselectedLabelColor: Colors.white.withValues(alpha: 0.70),
                labelColor: Colors.white,
                tabs: const [
                  Tab(text: 'Commands'),
                  Tab(text: 'Properties'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildListSection(
                    items: legendCommands,
                    icon: Icons.gamepad_rounded,
                    color: primary,
                    isSmallScreen: isSmallScreen,
                    textScaleFactor: textScaleFactor,
                    paddingScale: paddingScale,
                  ),
                  _buildListSection(
                    items: legendProperties,
                    icon: Icons.list_alt_rounded,
                    color: propertiesAccent,
                    isSmallScreen: isSmallScreen,
                    textScaleFactor: textScaleFactor,
                    paddingScale: paddingScale,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSection({
    required List<Map<String, String>> items,
    required IconData icon,
    required Color color,
    required bool isSmallScreen,
    required double textScaleFactor,
    required double paddingScale,
  }) {
    return ListView.separated(
      padding: EdgeInsets.all(16 * paddingScale),
      itemCount: items.length,
      separatorBuilder: (_, __) => Divider(
        height: 24 * paddingScale,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(6 * paddingScale),
              decoration: BoxDecoration(
                // Fondo sólido (sin transparencia) para mejor legibilidad.
                color: Color.lerp(color, const Color(0xFF0D1B2A), 0.70),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon, 
                size: isSmallScreen ? 16 : 18, 
                color: color
              ),
            ),
            SizedBox(width: 16 * paddingScale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['command'] ?? item['property'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: (isSmallScreen ? 13 : 14) * textScaleFactor,
                    ),
                  ),
                  SizedBox(height: 4 * paddingScale),
                  Text(
                    item['description'] ?? '',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: (isSmallScreen ? 12 : 13) * textScaleFactor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}