import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';
import 'theme.dart';

class CropGuardApp extends StatelessWidget {
  const CropGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CropGuard',
      theme: CropGuardTheme.light,
      home: const SplashScreen(),
    );
  }
}