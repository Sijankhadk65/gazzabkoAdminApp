import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:gazzabko_admin_app/model/attendance.dart';
import 'package:gazzabko_admin_app/model/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  @nullable
  String get accType;
  @nullable
  String get admin;
  @nullable
  String get area;
  @nullable
  BuiltList<Attendance> get attendance;
  @nullable
  String get email;
  @nullable
  String get name;
  @nullable
  String get photoUrl;
  @nullable
  String get password;

  factory User([void Function(UserBuilder) updates]) = _$User;
  User._();
  static Serializer<User> get serializer => _$userSerializer;
}

User parseJsonToUser(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(User.serializer, json);
}

Map<String, dynamic> convertUserToJson(User user) => {
      "accType": user.accType,
      "name": user.name,
      "admin": user.admin,
      "area": user.area,
      "email": user.email,
      "password": user.password
    };
