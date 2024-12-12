import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/app_routes.dart';
import 'core/ui/theme_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.home,
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.lightTheme,
        supportedLocales: const [
          Locale('en', 'US'), // Inglês
          Locale('pt', 'BR'), // Português do Brasil
        ],
        localizationsDelegates:  const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      );
}
