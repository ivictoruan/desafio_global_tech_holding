
import 'package:flutter/material.dart';

import '../../../model/question.dart';

class QuestionField extends StatelessWidget {
  final Question question;

  const QuestionField({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case 1:
        return TextFormField(
          decoration: InputDecoration(labelText: question.name),
          initialValue: question.value,
        );
      case 2:
        return TextFormField(
          decoration: InputDecoration(
            labelText: question.name,
            hintText: "dd/mm/yyyy",
          ),
          initialValue: question.value,
        );
      case 3:
        return TextFormField(
          decoration: InputDecoration(labelText: question.name),
          keyboardType: TextInputType.number,
          initialValue: question.value,
        );
      case 4:
        return TextFormField(
          decoration: InputDecoration(
            labelText: question.name,
            prefixText: "R\$ ",
          ),
          keyboardType: TextInputType.number,
          initialValue: question.value,
        );
      case 5:
        // Quando o tipo for 5, temos uma lista de opções (dropdown)
        return DropdownButtonFormField<int>(
          decoration: InputDecoration(labelText: question.name),
          value: question.value != null
              ? int.tryParse(
                  question.value!) // Tentando converter o valor para o ID
              : null,
          items: question.optionsList!
              .map((option) => DropdownMenuItem<int>(
                    value: option.id,
                    child: Text(option.name),
                  ))
              .toList(),
          onChanged: (value) {},
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
