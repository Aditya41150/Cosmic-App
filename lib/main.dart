import 'package:cosmic/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => const CosmicApp()));
}

class CosmicApp extends StatelessWidget {
  const CosmicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cosmic',
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
