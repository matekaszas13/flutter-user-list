import 'package:flutter/material.dart';
import 'package:flutter_user_list/i18n/i18n.dart';
import 'package:flutter_user_list/models/field/field.dart';
import 'package:flutter_user_list/modules/dto/update_user_params.dart';
import 'package:flutter_user_list/modules/users/data/users_providers.dart';
import 'package:flutter_user_list/modules/users/widgets/snackbar.dart';
import 'package:flutter_user_list/modules/users/widgets/user_form.dart';
import 'package:flutter_user_list/presentation/utils/form_handler.dart';
import 'package:flutter_user_list/utils/theme_mode_value_provider.dart';
import 'package:flutter_user_list/utils/translated_value.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateUserBottomSheet extends HookConsumerWidget {
  const UpdateUserBottomSheet({
    required this.firstName,
    required this.lastName,
    required this.id,
    super.key,
  });

  final String firstName;
  final String lastName;
  final int id;

  @override
  Widget build(context, ref) {
    final isDarkMode = ref.watch(themeModeValueProvider);

    final formHandler = useFormHandler(
      {
        "first_name_field": Field.text(
          key: "first_name_field",
          initialValue: firstName,
          label: TranslatedValue.key("fields.first_name"),
        ),
        "last_name_field": Field.text(
          key: "last_name_field",
          initialValue: lastName,
          label: TranslatedValue.key("fields.last_name"),
        ),
      },
    );

    final isFirstNameEmpty = formHandler.getField<Field>('first_name_field').isEmpty;
    final isLastNameEmpty = formHandler.getField<Field>('last_name_field').isEmpty;

    final mutationIsLoading = ref.watch(updateUserMutation).isLoading;

    Future onSubmit() async {
      final params = UpdateUserParams(
        id: id,
        firstName: formHandler.getFieldValue('first_name_field'),
        lastName: formHandler.getFieldValue('last_name_field'),
      );
      final response = await ref.read(updateUserMutation).mutate(params);
      if (response.hasError) {
        Snackbar.show(context, response.error.toString(), Colors.red);
      } else {
        Navigator.of(context).pop();
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      color: isDarkMode ? const Color.fromARGB(255, 92, 70, 156) : const Color.fromARGB(255, 114, 134, 211),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            UserForm(
              formHandler: formHandler,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: mutationIsLoading || (isFirstNameEmpty || isLastNameEmpty) ? null : onSubmit,
              child: mutationIsLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      context.tr('submit'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
