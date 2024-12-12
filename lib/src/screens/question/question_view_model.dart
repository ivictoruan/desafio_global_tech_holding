import 'dart:developer';

import 'package:flutter/material.dart';

import '../../model/question.dart';
import '../../model/repository.dart';

class QuestionsViewModel extends ChangeNotifier {
  final QuestionsRepository _repository;
  final List<Question> _questions = [];
  int _currentPage = 0;
  final int _questionsPerPage = 5;
  bool _isLoading = false;

  QuestionsViewModel({required QuestionsRepository repository})
      : _repository = repository {
    _load();
  }

  bool get isLoading => _isLoading;

  List<Question> get questions => _questions;

  List<Question> get questionsPages => _questions
      .skip(_currentPage * _questionsPerPage)
      .take(_questionsPerPage)
      .toList();

  int get currentPage => _currentPage;

  int get totalPages => (_questions.length / _questionsPerPage).ceil();

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();
    try {
      final loadedQuestions = await _repository.fetchQuestions();
      _questions.addAll(loadedQuestions);
    } catch (e) {
      debugPrint('Erro ao carregar perguntas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextPage() {
    if (_currentPage < totalPages - 1) {
      _currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }

  void updateQuestionValue(int index, String? value) {
    if (index >= 0 && index < _questions.length) {
      final question = _questions[index];
      _questions[index] = question.copyWith(value: () => value);
      log('Alterando campo "${question.name}" para: $value');
      notifyListeners();
    }
  }

  Map<int, String?> validateQuestions() {
    final errors = <int, String?>{};
    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final error = _validateQuestion(question);
      if (error != null) {
        errors[i] = error;
      }
    }
    return errors;
  }

  String? _validateQuestion(Question question) {
    if (question.value == null || question.value!.isEmpty) {
      return "Este campo é obrigatório";
    }
    switch (question.type) {
      case 2:
        final dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
        if (!dateRegExp.hasMatch(question.value!)) {
          return "Insira uma data válida no formato dd/mm/yyyy";
        }
        break;
      case 3:
      case 4:
        if (double.tryParse(question.value!) == null) {
          return "Insira um número válido";
        }
        break;
      case 5:
        if (int.tryParse(question.value!) == null) {
          return "Por favor, selecione uma opção válida";
        }
        break;
    }
    return null;
  }

  void resetQuestions() {
    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      _questions[i] = question.copyWith(value: () => null);
    }
    log('Todas as perguntas foram redefinidas');
    notifyListeners();
  }
}
