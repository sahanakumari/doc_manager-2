part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}


class UserAuthenticated extends LoginState {

  UserAuthenticated();

  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);

  @override
  List<Object> get props => [message];
}