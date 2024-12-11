import '../external/api_client.dart';
import 'question.dart';
import 'question_adapter.dart';

class QuestionsService {
  Future<List<Question>> fetchQuestions() async {
    const apiData = ApiClient.rawData;
    return Future.value(QuestionAdapter.adapt(apiData));
  }
}
