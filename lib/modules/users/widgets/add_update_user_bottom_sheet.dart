import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_user_list/i18n/i18n_provider.dart';
import 'package:flutter_user_list/modules/dto/update_user_params.dart';
import 'package:flutter_user_list/modules/users/data/users_providers.dart';
import 'package:flutter_user_list/modules/users/widgets/snackbar.dart';
import 'package:flutter_user_list/utils/theme_mode_value_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../dto/add_new_user_params.dart';

class AddUserBottomSheet extends HookConsumerWidget {
  const AddUserBottomSheet({
    this.firstName,
    this.lastName,
    this.userId,
    this.isUpdate = false,
    super.key,
  });

  final String? firstName;
  final String? lastName;
  final int? userId;
  final bool isUpdate;

  @override
  Widget build(context, ref) {
    final ValueNotifier<Map<String, String>> formValues =
        useState({'firstName': firstName ?? '', 'lastName': lastName ?? ''});

    final isDarkMode = ref.watch(themeModeValueProvider);

    final formKey = useState(GlobalKey<FormState>());
    final mutationIsLoading = ref.watch(addNewUserMutation).isLoading;

    Future onSubmit() async {
      final AsyncValue<dynamic> response;
      formKey.value.currentState!.validate();
      formKey.value.currentState!.save();
      if (isUpdate) {
        final params = UpdateUserParams(
          id: userId!,
          firstName: formValues.value['firstName']!,
          lastName: formValues.value['lastName']!,
        );

        response = await ref.read(updateUserMutation).mutate(params);
      } else {
        final params = AddNewUserParams(
          firstName: formValues.value['firstName']!,
          lastName: formValues.value['lastName']!,
        );

        response = await ref.read(addNewUserMutation).mutate(params);
      }
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
        body: Form(
          key: formKey.value,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      initialValue: formValues.value['firstName'],
                      validator: (value) {
                        if (value == null || value.isEmpty || value.trim().length <= 1) {
                          return 'Cannot be empty.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        formValues.value['firstName'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      initialValue: formValues.value['lastName'],
                      validator: (value) {
                        if (value == null || value.isEmpty || value.trim().length <= 1) {
                          return 'Cannot be empty.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        formValues.value['lastName'] = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: mutationIsLoading ? null : onSubmit,
                  child: mutationIsLoading
                      ? const CircularProgressIndicator()
                      : Text(context.tr(isUpdate ? 'update_user' : 'add_user'))),
            ],
          ),
        ),
      ),
    );
  }
}
