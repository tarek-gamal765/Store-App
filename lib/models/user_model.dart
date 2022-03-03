class UserModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? imageUrl;
  String? joinedAt;
  String? createdAt;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.imageUrl,
    this.joinedAt,
    this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    imageUrl = json['imageUrl'];
    joinedAt = json['joinedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'joinedAt': joinedAt,
      'createdAt': createdAt,
    };
  }
}
