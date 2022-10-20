import 'package:safesign_app/core/models/user_model_keys.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? pin;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.pin,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[UserModelKeys.id] ?? "",
      email: map[UserModelKeys.email] ?? "",
      lastName: map[UserModelKeys.lastName] ?? "",
      firstName: map[UserModelKeys.firstName] ?? "",
      pin: map[UserModelKeys.pin] ?? "",
    );
  }

  Map<String, dynamic> toMap(UserModel user) {
    return {
      UserModelKeys.id: user.id,
      UserModelKeys.email: user.email,
      UserModelKeys.lastName: user.lastName,
      UserModelKeys.firstName: user.firstName,
      UserModelKeys.pin: user.pin,
    };
  }

  @override
  List<Object?> get props => [id];
}
