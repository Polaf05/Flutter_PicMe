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
  final String address;
  final String contact;
  final String display;
  final String id;

  Client(
      {this.name,
      this.email,
      this.role,
      this.address,
      this.contact,
      this.display,
      this.id});
}
