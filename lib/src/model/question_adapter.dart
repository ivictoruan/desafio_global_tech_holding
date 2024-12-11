import 'option.dart';
import 'question.dart';

class QuestionAdapter {
  static List<Question> adapt(List<Map<String, dynamic>> rawData) {
    return rawData.map((data) {
      final type = data['type'] as int;
      List<Option>? optionsList;

      // Se o tipo for 5, que representa uma pergunta com opções, adaptamos as opções
      if (type == 5) {
        optionsList = (data['optionsList'] as List)
            .map((optionData) => Option(
                  id: optionData['id'] as int,
                  name: optionData['name'] as String,
                ))
            .toList();
      }

      return Question(
        name: data['name'] as String,
        type: type,
        value: data['value'] as String?,
        optionsList: optionsList,
      );
    }).toList();
  }
}
