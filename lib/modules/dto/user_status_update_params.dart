import 'package:flutter_user_list/models/status.dart';

class UserStatusUpdateParams {
  UserStatusUpdateParams({
    required this.id,
    required this.status,
  });
  final int id;
  final Status status;
}
