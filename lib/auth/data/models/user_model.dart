class UserModel {
  int id;
  String name;
  String email;
  String avatar;
  String firstName;
  bool isTrial;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.firstName,
    required this.isTrial,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      firstName: json['first_name'],
      isTrial: json['is_trial'],
    );
  }
}
