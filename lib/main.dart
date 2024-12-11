import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app_widget.dart';
import 'src/model/repository.dart';
import 'src/model/service.dart';
import 'src/screens/question/question_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final service = QuestionsService();
        final respository = QuestionsRepository(service);
        return QuestionsViewModel(respository);
      },
      child: const AppWidget(),
    ),
  );
}
