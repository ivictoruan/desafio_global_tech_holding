import 'option.dart';

class Question {
  final String name;
  final int type;
  final String? value;
  final List<Option>? optionsList;

  Question({
    required this.name,
    required this.type,
    this.value,
    this.optionsList,
  });
}