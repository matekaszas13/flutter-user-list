class AddNewUserParams {
  AddNewUserParams({
    required this.firstName,
    required this.lastName,
    this.status = 'locked',
  });
  final String firstName;
  final String lastName;
  final String status;
}
