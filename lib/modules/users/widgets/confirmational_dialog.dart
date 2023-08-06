import 'package:flutter/material.dart';
import 'package:flutter_user_list/modules/users/data/users_providers.dart';
import 'package:flutter_user_list/utils/mutation_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfirmationalDialog extends StatelessWidget {
  const ConfirmationalDialog(
      {required this.id,
      required this.fullName,
      required this.handleUserDelete,
      super.key});

  final int id;
  final String fullName;
  final void Function(BuildContext context, int id) handleUserDelete;

  @override
  Widget build(context) {
    return Consumer(
      builder: (context, ref, _) {
        final isLoading = ref.watch(deleteUserMutation.isLoading);
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(16),
            child: AlertDialog(
              title: Text("Are you sure you want to delete $fullName?"),
              actions: [
                TextButton(
                  onPressed:
                      isLoading ? null : () => handleUserDelete(context, id),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Delete'),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed:
                      isLoading ? null : () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
