import 'package:flutter/material.dart';

import '../../../model/question.dart';

class QuestionField extends StatelessWidget {
  final Question question;
  final void Function(String?) onChanged;

  const QuestionField({
    super.key,
    required this.question,
    required this.onChanged,
  });

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Este campo é obrigatório";
    }
    switch (question.type) {
      case 2:
        final dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
        if (!dateRegExp.hasMatch(value)) {
          return "Insira uma data válida no formato dd/mm/yyyy";
        }
        break;
      case 3:
      case 4:
        if (double.tryParse(value) == null) {
          return "Insira um número válido";
        }
        break;
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final firstDate = DateTime(1900);
    final lastDate = DateTime(2100);

    final selectedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.inputOnly,
      keyboardType: TextInputType.url,
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('pt', 'BR'),
    );

    if (selectedDate != null) {
      final formattedDate =
          '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
      onChanged(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case 1:
        return TextFormField(
          decoration: InputDecoration(labelText: question.name),
          initialValue: question.value,
          onChanged: onChanged,
          validator: _validate,
        );
      case 2:
        return TextFormField(
          decoration: InputDecoration(
            labelText: question.name,
            hintText: "dd/mm/yyyy",
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
          validator: _validate,
        );
      case 3:
        return TextFormField(
          decoration: InputDecoration(labelText: question.name),
          keyboardType: TextInputType.number,
          initialValue: question.value,
          onChanged: onChanged,
          validator: _validate,
        );
      case 4:
        return TextFormField(
          decoration: InputDecoration(
            labelText: question.name,
            prefixText: "R\$ ",
          ),
          keyboardType: TextInputType.number,
          initialValue: question.value,
          onChanged: onChanged,
          validator: _validate,
        );
      case 5:
        return DropdownButtonFormField<int>(
          key: ValueKey('${question.name}-${question.value}'),
          decoration: InputDecoration(labelText: question.name),
          value: int.tryParse(question.value ?? ''),
          validator: (value) {
            if (value == null) {
              return "Por favor, selecione uma opção.";
            }
            return null;
          },
          items: question.optionsList!
              .map((option) => DropdownMenuItem<int>(
                    value: option.id,
                    child: Text(option.name),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value.toString());
            }
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
