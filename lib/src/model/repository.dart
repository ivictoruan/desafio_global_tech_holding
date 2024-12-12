import 'question.dart';
import 'service.dart';

class QuestionsRepository {
  final QuestionsService _service;

  QuestionsRepository({required QuestionsService service}) : _service = service;

  Future<List<Question>> fetchQuestions() async {
    return await _service.fetchQuestions();
  }
}
