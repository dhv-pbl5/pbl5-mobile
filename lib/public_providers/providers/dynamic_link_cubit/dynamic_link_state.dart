part of 'dynamic_link_cubit.dart';

@freezed
class DynamicLinkState with _$DynamicLinkState {
  const factory DynamicLinkState.initial({
    String? errorMessage,
    String? currentResetPasswordToken,
    String? currentResetPasswordEmail,
  }) = _Initial;
}
