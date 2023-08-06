class AddNewUserParams {
  AddNewUserParams({
    required this.firstName,
    required this.lastName,
    this.status = 'active',
  });
  final String firstName;
  final String lastName;
  final String status;
}
