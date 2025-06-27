part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {}

final class Unauthenticated extends AuthState {
  final String message;

  const Unauthenticated({required this.message});
}

final class UserDataFailed extends AuthState {
  final String errMessage;

  const UserDataFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
