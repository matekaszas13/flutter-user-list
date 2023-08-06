import 'package:flutter_user_list/models/user.dart';
import 'package:flutter_user_list/modules/dto/add_new_user_params.dart';
import 'package:flutter_user_list/modules/dto/update_user_params.dart';
import 'package:flutter_user_list/modules/dto/user_status_update_params.dart';
import 'package:flutter_user_list/repositories/users_repository.dart';
import 'package:flutter_user_list/utils/mutation_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_providers.g.dart';

@riverpod
Future<List<User>> getUsers(GetUsersRef ref) async {
  return ref.watch(usersRepositoryProvider).getUsers();
}

final updateUserStatusMutation = MutationStateNotifierProvider(
  (ref) => MutationProvider<dynamic, UserStatusUpdateParams>(
    mutationFn: ref.read(usersRepositoryProvider).updateUserStatusById,
    onSuccess: (_, __) => ref.invalidate(getUsersProvider),
  ),
);

final deleteUserMutation = MutationStateNotifierProvider(
  (ref) => MutationProvider<dynamic, int>(
    mutationFn: ref.read(usersRepositoryProvider).deleteUserById,
    onSuccess: (_, __) => ref.invalidate(getUsersProvider),
  ),
);

final addNewUserMutation = MutationStateNotifierProvider(
  (ref) => MutationProvider<dynamic, AddNewUserParams>(
    mutationFn: ref.read(usersRepositoryProvider).addNewUser,
    onSuccess: (_, __) => ref.invalidate(getUsersProvider),
  ),
);

final updateUserMutation = MutationStateNotifierProvider(
    (ref) => MutationProvider<dynamic, UpdateUserParams>(
          mutationFn: ref.read(usersRepositoryProvider).updateUser,
          onSuccess: (_, __) => ref.invalidate(getUsersProvider),
        ));
