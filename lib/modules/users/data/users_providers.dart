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

final updateUserStatusMutation = MutationProvider.create(
  mutationFn: (ref, UserStatusUpdateParams params) async =>
      ref.read(usersRepositoryProvider).updateUserStatusById(params),
  onSuccess: (ref, __, ___) async => ref.invalidate(getUsersProvider),
);

final deleteUserMutation = MutationProvider.create(
  mutationFn: (ref, int params) async =>
      ref.read(usersRepositoryProvider).deleteUserById(params),
  onSuccess: (ref, __, ___) async => ref.invalidate(getUsersProvider),
);

final addNewUserMutation = MutationProvider.create(
  mutationFn: (ref, AddNewUserParams params) async =>
      ref.read(usersRepositoryProvider).addNewUser(params),
  onSuccess: (ref, __, ___) async => ref.invalidate(getUsersProvider),
);

final updateUserMutation = MutationProvider.create(
  mutationFn: (ref, UpdateUserParams params) async =>
      ref.read(usersRepositoryProvider).updateUser(params),
  onSuccess: (ref, __, ___) async => ref.invalidate(getUsersProvider),
);
