import 'package:flutter/material.dart';
import 'package:tekkenframadata/core/utils/moves_properties_legends.dart';

class HelpDialogWidget extends StatelessWidget {
  const HelpDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isLandscape = size.width > size.height;
    
 
    final textScaleFactor = MediaQuery.textScalerOf(context).scale(1);
    final paddingScale = isSmallScreen ? 0.8 : 1.0;

    return DefaultTabController(
      length: 2,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        ),
        elevation: 8,
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          width: size.width * (isSmallScreen ? 0.95 : 0.9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16 * paddingScale),
                child: Text(
                  'Move Notation Guide',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 18 : null,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(isSmallScreen ? 12 : 16),
                  ),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(isSmallScreen ? 12 : 16)),
                    color: colors.primary,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 
                      (textTheme.labelLarge?.fontSize ?? 14) * 0.9 : null,
                  ),
                  unselectedLabelColor: colors.onSurface.withValues(alpha: 0.6),
                  tabs: const [
                    Tab(text: 'Commands'),
                    Tab(text: 'Properties'),
                  ],
                ),
              ),
              SizedBox(
                height: isLandscape 
                    ? size.height * 0.4 
                    : size.height * (isSmallScreen ? 0.5 : 0.6),
                child: TabBarView(
                  children: [
                    _buildListSection(
                      items: legendCommands,
                      icon: Icons.gamepad_rounded,
                      color: colors.primary,
                      isSmallScreen: isSmallScreen,
                      textScaleFactor: textScaleFactor,
                      paddingScale: paddingScale,
                    ),
                    _buildListSection(
                      items: legendProperties,
                      icon: Icons.list_alt_rounded,
                      color: colors.secondary,
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
        actions: [
          IconButton(
            icon: Icon(Icons.close_rounded, 
              size: isSmallScreen ? 20 : 24),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Close',
          ),
        ],
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
                color: color.withValues(alpha: 0.1),
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
                      color: Colors.grey[700],
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