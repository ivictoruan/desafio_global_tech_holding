import 'package:flutter/material.dart';

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

  Question copyWith({
    String? name,
    int? type,
    ValueGetter<String?>? value,
    ValueGetter<List<Option>?>? optionsList,
  }) {
    return Question(
      name: name ?? this.name,
      type: type ?? this.type,
      value: value != null ? value() : this.value,
      optionsList: optionsList != null ? optionsList() : this.optionsList,
    );
  }
}
