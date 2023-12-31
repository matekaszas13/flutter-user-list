import 'package:flutter/material.dart';
import 'package:flutter_user_list/constans.dart';
import 'package:flutter_user_list/i18n/i18n.dart';
import 'package:flutter_user_list/models/field/field.dart';
import 'package:flutter_user_list/modules/dto/add_new_user_params.dart';
import 'package:flutter_user_list/modules/users/data/users_providers.dart';
import 'package:flutter_user_list/modules/users/widgets/snackbar.dart';
import 'package:flutter_user_list/presentation/utils/form_handler.dart';
import 'package:flutter_user_list/presentation/widgets/input_field/input_field.dart';
import 'package:flutter_user_list/utils/theme_mode_value_provider.dart';
import 'package:flutter_user_list/utils/translated_value.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddUserBottomSheet extends HookConsumerWidget {
  const AddUserBottomSheet({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final isDarkMode = ref.watch(themeModeValueProvider);

    final Map<String, SelectFieldOption> statusMapOptions = Map.fromEntries(
      statusOptions.map(
        (statusKey) => MapEntry(
          statusKey,
          SelectFieldOption(
            id: statusKey,
            label: TranslatedValue.key(statusKey),
            value: statusKey,
          ),
        ),
      ),
    );

    final formHandler = useFormHandler(
      {
        "first_name_field": Field.text(
          key: "first_name_field",
          initialValue: '',
          label: TranslatedValue.key("fields.first_name"),
        ),
        "last_name_field": Field.text(
          key: "last_name_field",
          initialValue: '',
          label: TranslatedValue.key("fields.last_name"),
        ),
        "status_select_field": Field.select(
          key: "status_select_field",
          initialValue: statusMapOptions['active'],
          label: TranslatedValue.key("status"),
          options: statusMapOptions,
        ),
      },
    );

    final isFieldsEmpty = formHandler.formHolder.fields.any((field) => field.isEmpty);

    final addUserMutation = ref.watch(addNewUserMutation);

    Future onSubmit() async {
      final params = AddNewUserParams(
        firstName: formHandler.getFieldValue('first_name_field'),
        lastName: formHandler.getFieldValue('last_name_field'),
        status: formHandler.getFieldValue('status_select_field').id,
      );

      final response = await addUserMutation(params);

      response.maybeWhen(
        error: (error, _) {
          Snackbar.show(context, response.error.toString(), Colors.red);
        },
        orElse: () {
          Navigator.of(context).pop();
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      color: isDarkMode ? const Color.fromARGB(255, 92, 70, 156) : const Color.fromARGB(255, 114, 134, 211),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InputField<dynamic>(
                    field: formHandler.getField("first_name_field"),
                    formHandler: formHandler,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InputField<dynamic>(
                    field: formHandler.getField("last_name_field"),
                    formHandler: formHandler,
                  ),
                ),
              ],
            ),
            // UserForm(
            //   formHandler: formHandler,
            // ),
            const SizedBox(height: 16),
            InputField(
              field: formHandler.getField("status_select_field"),
              formHandler: formHandler,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: addUserMutation.isLoading || isFieldsEmpty ? null : onSubmit,
              child: addUserMutation.isLoading
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
