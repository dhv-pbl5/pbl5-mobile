import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/app_common_data/routes/app_routes.dart';
import '/generated/translations.g.dart';
import '/models/credential/credential.dart';
import '/services/api_models/api_response/api_response.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/helpers/dialogs/dialog_helper.dart';
import '/shared_customization/helpers/utilizations/dio_parse_error.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/app_common_data/common_data/common_data.dart';

class AppDio with DioMixin implements Dio {
  bool isRefreshingToken = false;
  AppDio() {
    options = BaseOptions(
      connectTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: false,
          responseHeader: false,
        ),
      );
    }

    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final String? token = sp.prefs.getString(AppStrings.ACCESS_TOKEN);
        if (token != null && token.isNotEmpty) {
          options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        debugPrint("DIO ERROR DATA: ${error.response?.data}".debug);
        try {
          if (sp.accessToken.isNotEmptyOrNull &&
              error.response != null &&
              error.requestOptions.headers.containsKey('Authorization') &&
              error.response?.data is Map<String, dynamic>) {
            String errorCode = error.response?.data["error"]["code"];
            switch (errorCode) {
              case AppStrings.INVALID_TOKEN_ERROR_CODE:
              case AppStrings.REVOKED_TOKEN_ERROR_CODE:
              case AppStrings.EXPIRED_TOKEN_ERROR_CODE:
                if (isRefreshingToken) {
                  await Future.doWhile(() async {
                    await Future.delayed(const Duration(milliseconds: 500));
                    return !isRefreshingToken;
                  });
                } else {
                  isRefreshingToken = true;
                  await sp.setToken('', sp.refreshToken!);
                  ApiResponse<Credential> credential = await apis.refreshToken({
                    "refresh_token": sp.refreshToken,
                  });
                  isRefreshingToken = false;
                  if (credential.data != null) {
                    sp.setToken(credential.data!.accessToken!,
                        credential.data!.refreshToken!);
                    var response = await request(
                        error.requestOptions.baseUrl +
                            error.requestOptions.path,
                        data: error.requestOptions.data,
                        queryParameters: error.requestOptions.queryParameters,
                        options: Options(
                            method: error.requestOptions.method,
                            headers: error.requestOptions.headers
                              ..['Authorization'] =
                                  'Bearer ${sp.accessToken}'));
                    handler.resolve(response);
                    return;
                  } else {
                    throw AppStrings.INVALID_REFRESH_TOKEN_ERROR_CODE;
                  }
                }
                break;
              case AppStrings.INVALID_REFRESH_TOKEN_ERROR_CODE:
              case AppStrings.EXPIRED_REFRESH_TOKEN_ERROR_CODE:
              case AppStrings.REVOKED_REFRESH_TOKEN_ERROR_CODE:
                throw errorCode;
              default:
                return handler.next(error);
            }
          }
        } catch (err) {
          isRefreshingToken = false;
          if (error.response?.data['error'] != null) {
            showErrorDialog(
              GlobalKeyVariable.navigatorState.currentContext!,
              title: tr(LocaleKeys.CommonData_Error),
              content: parseError(error),
            ).then((value) {
              sp.prefs.clear();
              GlobalKeyVariable.navigatorState.currentContext!
                  .pushNamed(Routes.loginScreen);
            });
          }
        }
        return handler.next(error);
      },
    ));

    httpClientAdapter = HttpClientAdapter();
  }
}
