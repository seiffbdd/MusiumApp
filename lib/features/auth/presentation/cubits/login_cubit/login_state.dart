part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailed extends LoginState {
  final String errMessage;

  const LoginFailed({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}
