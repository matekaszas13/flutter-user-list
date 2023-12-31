import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_user_list/i18n/i18n.dart';
import 'package:flutter_user_list/models/status.dart';
import 'package:flutter_user_list/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class UserSlidableCard extends HookConsumerWidget {
  const UserSlidableCard(
      {required this.user,
      required this.openUpdateUserBottomSheet,
      required this.openDeleteConfirmationalDialog,
      required this.handleStatusChange,
      super.key});

  final User user;
  final Function({required BuildContext context, required String firstName, required String lastName, required int id})
      openUpdateUserBottomSheet;
  final Function(BuildContext context, int id, String fullName) openDeleteConfirmationalDialog;
  final Function(User user) handleStatusChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDate = DateFormat('yyyy/MM/dd HH:mm').format(user.createdAt.toLocal());

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Slidable(
        key: ValueKey(user.id),
        endActionPane: ActionPane(motion: const DrawerMotion(), dragDismissible: false, children: [
          SlidableAction(
            onPressed: (context) => openUpdateUserBottomSheet(
                context: context, firstName: user.firstName, lastName: user.lastName, id: user.id),
            backgroundColor: const Color.fromARGB(100, 92, 70, 156),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: context.tr('edit'),
            flex: 1,
          ),
          SlidableAction(
            onPressed: (context) => openDeleteConfirmationalDialog(context, user.id, user.fullName),
            backgroundColor: const Color.fromARGB(255, 214, 54, 54),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: context.tr('delete'),
            flex: 1,
          ),
        ]),
        child: Card(
          child: ListTile(
            title: Text(user.fullName),
            subtitle: Text(formattedDate),
            trailing: IconButton(
              onPressed: () => handleStatusChange(user),
              icon: user.status == Status.active ? const Icon(Icons.lock_open) : const Icon(Icons.lock),
            ),
          ),
        ),
      ),
    );
  }
}
