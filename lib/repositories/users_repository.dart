import 'package:dio/dio.dart';
import 'package:flutter_user_list/models/user.dart';
import 'package:flutter_user_list/modules/dto/add_new_user_params.dart';
import 'package:flutter_user_list/modules/dto/update_user_params.dart';
import 'package:flutter_user_list/modules/dto/user_status_update_params.dart';
import 'package:flutter_user_list/services/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_repository.g.dart';

@riverpod
UsersRepository usersRepository(UsersRepositoryRef ref) => UsersRepository(ref);

class UsersRepository {
  UsersRepository(this.ref);

  final Ref ref;

  Dio get dio => ref.read(dioProvider);

  Future<List<User>> getUsers() async {
    final response = await dio.get('/users.json');
    return User.listFromResponse(response.data);
  }

  Future<Response<dynamic>> updateUserStatusById(UserStatusUpdateParams params) async {
    final response = await dio.put('/users/${params.id}.json', data: {
      'status': params.status.status,
    });
    return response;
  }

  Future<Response<dynamic>> deleteUserById(int id) async {
    final response = await dio.delete('/users/$id.json');
    return response;
  }

  Future<Response<dynamic>> addNewUser(AddNewUserParams params) async {
    final response = await dio.post('/users.json', data: {
      'first_name': params.firstName,
      'last_name': params.lastName,
      'status': params.status,
    });
    return response;
  }

  Future<Response<dynamic>> updateUser(UpdateUserParams params) async {
    final response = await dio.put('/users/${params.id}.json', data: {
      'first_name': params.firstName,
      'last_name': params.lastName,
    });
    return response;
  }
}
