import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/question/question_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/question/question_view_model.dart';

class AppRoutes {
  static const String home = '/';
  static const String questions = '/questions';

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    MaterialPageRoute buildHome() => MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );

    switch (routeSettings.name) {
      case home:
        return buildHome();
      case questions:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            final arguments = routeSettings.arguments as Map<String, Object>;

            final String featureName = arguments['featureName'] as String;

            return QuestionsScreen(
              featureName: featureName,
              viewModel: QuestionsViewModel(repository: context.read()),
            );
          },
        );
      default:
        return buildHome();
    }
  }
}
