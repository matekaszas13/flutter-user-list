import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_user_list/models/status.dart';
import 'package:flutter_user_list/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class UserSlidableCard extends ConsumerWidget {
  const UserSlidableCard(
      {required this.user,
      required this.openUpdateUserBottomSheet,
      required this.openDeleteConfirmationalDialog,
      required this.handleStatusChange,
      super.key});

  final User user;
  final Function(BuildContext context, String firstName, String lastName,
      int id, bool isUpdate) openUpdateUserBottomSheet;
  final Function(BuildContext context, int id, String fullName)
      openDeleteConfirmationalDialog;
  final Function(User user) handleStatusChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDate =
        DateFormat('yyyy/MM/dd HH:mm').format(user.createdAt.toLocal());

    return Slidable(
      key: ValueKey(user.id),
      endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dragDismissible: false,
          children: [
            SlidableAction(
              onPressed: (context) => openUpdateUserBottomSheet(
                  context, user.firstName, user.lastName, user.id, true),
              backgroundColor: const Color.fromARGB(100, 92, 70, 156),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              flex: 1,
            ),
            SlidableAction(
              onPressed: (context) => openDeleteConfirmationalDialog(
                  context, user.id, user.fullName),
              backgroundColor: const Color.fromARGB(231, 214, 54, 54),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              flex: 1,
            ),
          ]),
      child: Card(
        child: ListTile(
          title: Text(user.fullName),
          subtitle: Text(formattedDate),
          trailing: IconButton(
              onPressed: () => handleStatusChange(user),
              icon: user.status == Status.active
                  ? const Icon(Icons.lock_open)
                  : const Icon(Icons.lock)),
        ),
      ),
    );
  }
}
