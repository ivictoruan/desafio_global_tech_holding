import 'question.dart';
import 'service.dart';

class QuestionsRepository {
  final QuestionsService _service;

  QuestionsRepository(this._service);

  Future<List<Question>> fetchQuestions() async {
    return await _service.fetchQuestions();
  }
}
