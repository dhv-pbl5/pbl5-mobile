import '/services/apis/api_client.dart';

class AuthenticationRepositoty {
  final ApiClient apis;
  const AuthenticationRepositoty({required this.apis});

  // Future<ApiResponse<Credential>> login(String email, String password) =>
  //     apis.login({
  //       "email": email,
  //       "password": password,
  //       "role": Role.manager.name.toUpperCase(),
  //     });

  // Future<ApiResponse<User>> register({
  //   required User user,
  //   required String pwd,
  //   required String confirmPwd,
  // }) =>
  //     apis.register({
  //       ...user.toJson(),
  //       "firstname": user.firstName,
  //       "lastname": user.lastName,
  //       "password": pwd,
  //       "password_confirmation": confirmPwd
  //     });

  Future logOut() => apis.logout();
  // Future logOutAll() => apis.logoutAll();

  // Future<Credential> refreshToken(String refreshToken) async {
  //   try {
  //     return (await apis.refreshToken({"refresh_token": refreshToken})).data
  //         as Credential;
  //   } catch (err) {
  //     rethrow;
  //   }
  // }

  // Future<bool> confirmAccount(String token) async {
  //   try {
  //     return (await apis.confirmAccount(token)).status == 'success';
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<bool> resendEmail(String email) async {
  //   try {
  //     return (await apis.resendMail({"email": email})).status == "success";
  //   } catch (err) {
  //     rethrow;
  //   }
  // }

  // Future<bool> forgotPassword(String email) async {
  //   try {
  //     return (await apis.forgotPassword({"email": email})).status == "success";
  //   } catch (err) {
  //     rethrow;
  //   }
  // }

  // Future<bool> resetPassword({
  //   required String email,
  //   required String pwd,
  //   required String confirmPwd,
  //   required String resetPwdToken,
  // }) async {
  //   try {
  //     return (await apis.resetPassword({
  //           "email": email,
  //           "password": pwd,
  //           "password_confirmation": confirmPwd,
  //           "reset_password_token": resetPwdToken
  //         }))
  //             .status ==
  //         "success";
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<bool> changePassword({
  //   required String oldPwd,
  //   required String newPwd,
  //   required String confirmNewPwd,
  // }) async {
  //   try {
  //     return (await apis.changePassword({
  //           "old_password": oldPwd,
  //           "new_password": newPwd,
  //           "confirm_new_password": confirmNewPwd
  //         }))
  //             .status ==
  //         "success";
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future requestRemove() => apis.requestRemove();

  // Future deleteAccount(String token) => apis.deleteUser({"token": token});
}
