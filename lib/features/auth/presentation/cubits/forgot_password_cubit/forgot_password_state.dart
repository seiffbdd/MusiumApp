part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class SendingPasswordResetEmailLoading extends ForgotPasswordState {}

final class SendingPasswordResetEmailSuccess extends ForgotPasswordState {}

final class SendingPasswordResetEmailFailed extends ForgotPasswordState {
  final String errMessage;

  const SendingPasswordResetEmailFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
