import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final Data data;
  final String message;

  UserModel({
    required this.data,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  final User user;
  final String accessToken;
  final String tokenType;

  Data({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class User {
  final String name;
  final String email;
  final String fcmToken;

  User({
    required this.name,
    required this.email,
    required this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "fcm_token": fcmToken,
      };
}
