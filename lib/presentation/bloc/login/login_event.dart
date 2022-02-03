part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
}

class AuthenticateUserEvent extends LoginEvent {
  final String msisdn;


   AuthenticateUserEvent(this.msisdn,);

  @override
  List<Object> get props => [msisdn];
}
