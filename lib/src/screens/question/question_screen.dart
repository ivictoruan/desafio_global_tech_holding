import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'question_view_model.dart';
import 'widgets/question_field_widget.dart';

class QuestionsScreen extends StatelessWidget {
  final String featureName;
  const QuestionsScreen({super.key, required this.featureName});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuestionsViewModel>();

    if (viewModel.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
          ),
        ),
        // leadingWidth: 72,
        title: const Text('Voltar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                featureName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
                'Precisamos de algumas informações para personalizar mais ofertas para você.'),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.questions.length,
                itemBuilder: (context, index) {
                  return QuestionField(
                    question: viewModel.questions[index],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: viewModel.currentPage > 0
                      ? () => viewModel.previousPage()
                      : null,
                  child: const Text("Anterior"),
                ),
                ElevatedButton(
                  onPressed: viewModel.currentPage < viewModel.totalPages - 1
                      ? () => viewModel.nextPage()
                      : null,
                  child: const Text("Próximo"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Simulação concluída"),
                    content: const Text(
                        "Recebemos seus dados, retornaremos com as melhores ofertas."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              },
              child: const Text("Simular"),
            )
          ],
        ),
      ),
    );
  }
}
