class UserCreds {
  final String uid;
  final bool anon;
  final String email;

  UserCreds({this.uid, this.anon, this.email});
}

class Client {
  final String name;
  final String email;
  final String role;

  Client({this.name, this.email, this.role});
}
