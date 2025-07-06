part of 'sign_out_cubit.dart';

sealed class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object> get props => [];
}

final class SignOutInitial extends SignOutState {}

final class SignOutLoading extends SignOutState {}

final class SignOutFailed extends SignOutState {
  final String errMessage;

  const SignOutFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
