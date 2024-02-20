import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/models/credential/credential.dart';
import '../api_models/api_response/api_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  ///
  /// Authentication
  ///
  @POST('/auth/login')
  Future<ApiResponse<Credential>> login(@Body() Map<String, dynamic> body);

  @POST('/auth/logout')
  Future<ApiResponse> logout();

  @POST('/auth/refresh-token')
  Future<ApiResponse<Credential>> refreshToken(
      @Body() Map<String, dynamic> body);

  ///
  /// User
  ///
}
