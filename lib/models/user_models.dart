class UserResponse {
  UserResponse({
    this.message,
    this.user,
    this.status,
    this.token,
  });

  String? message;
  User? user;
  int? status;
  String? token;

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        message: json["message"],
        user: json["user"] != null ? User.fromMap(json["user"]) : null,
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "user": user != null ? user!.toMap() : null,
        "status": status,
        "token": token,
      };
}

class User {
  User({
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.address,
    this.id,
    this.isAdmin,
  });
  bool? isAdmin;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;
  String? id;

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        id: json["_id"],
        isAdmin: json["isAdmin"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "address": address,
        "_id": id,
        "isAdmin": isAdmin ?? false,
      };
}