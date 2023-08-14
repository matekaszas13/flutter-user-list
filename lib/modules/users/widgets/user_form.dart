import 'package:flutter/material.dart';
import 'package:flutter_user_list/presentation/utils/form_handler.dart';
import 'package:flutter_user_list/presentation/widgets/input_field/field_form.dart';
import 'package:flutter_user_list/presentation/widgets/input_field/input_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserForm extends ConsumerWidget {
  const UserForm({
    required this.formHandler,
    super.key,
  });
  final FormHandler<FormHandlerState> formHandler;

  @override
  Widget build(context, ref) {
    return FieldForm(
      isScrollControlled: true,
      fields: formHandler.formHolder.fields,
      formHandler: formHandler,
      fieldBuilder: (context, field) {
        return InputField<dynamic>(
          field: field,
          formHandler: formHandler,
        );
      },
    );
  }
}
