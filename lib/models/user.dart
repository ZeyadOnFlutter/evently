class UserModel {
  String id;
  String name;
  String email;
  List<String> favouriteIds;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favouriteIds,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      favouriteIds: (json['favouriteIds'] as List).cast<String>(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'favouriteIds': favouriteIds,
    };
  }
}
