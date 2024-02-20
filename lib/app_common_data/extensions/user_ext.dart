import '/models/user/user.dart';
import '/shared_customization/extensions/string_ext.dart';

extension UserExt on User? {
  String get fullname {
    if (this == null ||
        (this!.firstname.isNotEmptyOrNull && this!.lastname.isEmptyOrNull)) {
      return "";
    }
    return "${this!.firstname.isNotEmptyOrNull ? "${this!.firstname} " : ""}${this!.lastname ?? ""}";
  }
}
