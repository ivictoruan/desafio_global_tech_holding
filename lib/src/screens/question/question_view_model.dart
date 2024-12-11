import 'package:flutter/material.dart';

import '../../model/question.dart';
import '../../model/repository.dart';

class QuestionsViewModel extends ChangeNotifier {
  final QuestionsRepository _repository;
  final List<Question> _questions = [];
  int _currentPage = 0;
  final int _questionsPerPage = 5;
  bool _isLoading = false;

  QuestionsViewModel(this._repository) {
    _initialize();
  }

  bool get isLoading => _isLoading;

  List<Question> get questions => _questions
      .skip(_currentPage * _questionsPerPage)
      .take(_questionsPerPage)
      .toList();

  int get currentPage => _currentPage;

  int get totalPages => (_questions.length / _questionsPerPage).ceil();

  Future<void> _initialize() async {
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
}
