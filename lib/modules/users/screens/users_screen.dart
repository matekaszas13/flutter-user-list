import 'package:flutter/material.dart';
import 'package:flutter_user_list/i18n/i18n.dart';
import 'package:flutter_user_list/models/status.dart';
import 'package:flutter_user_list/models/user.dart';
import 'package:flutter_user_list/modules/dto/user_status_update_params.dart';
import 'package:flutter_user_list/modules/users/data/users_providers.dart';
import 'package:flutter_user_list/modules/users/widgets/add_user_bottom_sheet.dart';
import 'package:flutter_user_list/modules/users/widgets/confirmational_dialog.dart';
import 'package:flutter_user_list/modules/users/widgets/snackbar.dart';
import 'package:flutter_user_list/modules/users/widgets/update_user_bottom_sheet.dart';
import 'package:flutter_user_list/modules/users/widgets/user_slidable_card.dart';
import 'package:flutter_user_list/utils/theme_mode_value_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<User>> users = ref.watch(getUsersProvider);

    final isDarkMode = ref.watch(themeModeValueProvider);

    Future handleStatusChange(User user) async {
      final params = UserStatusUpdateParams(
        id: user.id,
        status: user.status == Status.active ? Status.locked : Status.active,
      );
      final response = await ref.read(updateUserStatusMutation).mutate(params);
      if (response.hasError) {
        Snackbar.show(context, response.error.toString(), Colors.red);
      }
    }

    Future handleUserDelete(BuildContext context, int id) async {
      final response = await ref.read(deleteUserMutation).mutate(id);
      if (response.hasError) {
        Snackbar.show(context, response.error.toString(), Colors.red);
      } else {
        Navigator.of(context).pop();
      }
    }

    void openDeleteConfirmationalDialog(BuildContext context, int id, String fullName) {
      showDialog(
          context: context,
          builder: (context) {
            return ConfirmationalDialog(
              id: id,
              fullName: fullName,
              handleUserDelete: handleUserDelete,
            );
          });
    }

    void openAddUpdateUserBottomSheet() {
      showBarModalBottomSheet(
        context: context,
        builder: (context) {
          return const AddUserBottomSheet();
        },
      );
    }

    void openUpdateUserBottomSheet({
      required BuildContext context,
      required String firstName,
      required String lastName,
      required int id,
    }) {
      showBarModalBottomSheet(
        context: context,
        builder: (context) {
          return UpdateUserBottomSheet(
            id: id,
            firstName: firstName,
            lastName: lastName,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('users')),
        actions: [
          IconButton(
            onPressed: openAddUpdateUserBottomSheet,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              ref.watch(themeModeValueProvider.notifier).setThemeMode();
            },
          ),
        ],
      ),
      body: users.isRefreshing
          ? const Center(child: CircularProgressIndicator())
          : users.when(
              data: (data) => RefreshIndicator(
                onRefresh: () => ref.refresh(getUsersProvider.future),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final User user = data[index];
                      return UserSlidableCard(
                          user: user,
                          openUpdateUserBottomSheet: openUpdateUserBottomSheet,
                          openDeleteConfirmationalDialog: openDeleteConfirmationalDialog,
                          handleStatusChange: handleStatusChange);
                    }),
              ),
              error: (e, s) => Text(e.toString() + s.toString()),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
