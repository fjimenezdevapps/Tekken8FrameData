import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekkenframadata/config/router/app_router.dart';
import 'config/theme/app_theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final AppTheme appTheme = AppTheme();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'Flutter Tekken Frame Data',
      theme: appTheme.getTheme(),
    );
  }
}