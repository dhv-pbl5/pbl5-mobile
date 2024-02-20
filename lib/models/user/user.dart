import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    String? id,
    String? firstname,
    String? lastname,
  }) = _User;

  static User get empty => const User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
