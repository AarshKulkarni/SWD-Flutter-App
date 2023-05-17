// ignore_for_file: non_constant_identifier_names, duplicate_ignore

class ReqUser {
  ReqUser(
      {required this.id,
      required this.email,
      required this.first_name,
      required this.last_name,
      required this.avatar});
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;
}
