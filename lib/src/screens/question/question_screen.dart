import 'dart:developer';

import 'package:flutter/material.dart';

import 'question_view_model.dart';
import 'widgets/question_field_widget.dart';

class QuestionsScreen extends StatefulWidget {
  final String featureName;
  final QuestionsViewModel viewModel;

  const QuestionsScreen({
    super.key,
    required this.featureName,
    required this.viewModel,
  });

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<bool?> mustComebackDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Quer voltar?"),
        content: const Text(
            "Se você sair, os dados serão perdidos. Tem certeza que deseja sair?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Sair"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final navigator = Navigator.of(context);

          final shouldExit = await mustComebackDialog();

          if (shouldExit ?? false) {
            navigator.pop();
          }
        }
      },
      child: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, __) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                final navigator = Navigator.of(context);

                final shouldExit = await mustComebackDialog();

                if (shouldExit ?? false) {
                  navigator.pop();
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
              ),
            ),
            title: const Text('Voltar'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.featureName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Precisamos de algumas informações para personalizar mais ofertas para você.',
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: widget.viewModel.questionsPages.length,
                    itemBuilder: (context, index) {
                      final question = widget.viewModel.questionsPages[index];
                      return QuestionField(
                        key: ObjectKey(question.name),
                        question: question,
                        onChanged: (value) {
                          final customIndex =
                              widget.viewModel.questions.indexOf(question);
                          log('index a ser alterado: $customIndex');
                          widget.viewModel.updateQuestionValue(
                            customIndex,
                            value.toString(),
                          );
                        },
                      );
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: widget.viewModel.currentPage > 0
                            ? () => widget.viewModel.previousPage()
                            : null,
                        child: const Text("Anterior"),
                      ),
                      ElevatedButton(
                        onPressed: widget.viewModel.currentPage <
                                widget.viewModel.totalPages - 1
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  widget.viewModel.nextPage();
                                }
                              }
                            : null,
                        child: const Text("Próximo"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _simulate,
                    child: const Text("Simular"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _simulate() async {
    final errors = widget.viewModel.validateQuestions();
    final navigator = Navigator.of(context);

    if (errors.isEmpty) {
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Simulação concluída"),
          content: const Text(
              "Recebemos seus dados, retornaremos com as melhores ofertas."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );

      widget.viewModel.resetQuestions();
      navigator.pop();
    } else {
      final errorMessages = errors.entries
          .map((e) => "Pergunta ${e.key + 1}: ${e.value}")
          .join("\n");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erro de validação"),
          content: Text(errorMessages),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
