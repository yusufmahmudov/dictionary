class Register {
  final String name;
  final String phone;
  final String password;
  bool success;
  int id;

  Register(
    this.id,
    this.success, {
    required this.name,
    required this.phone,
    required this.password,
  });
}
