import 'package:flutter/material.dart';

import 'core/ui/theme_config.dart';
import 'screens/home_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.lightTheme,
    );
  }
}
