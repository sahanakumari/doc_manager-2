
import 'package:equatable/equatable.dart';

import '../constants.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  @override
  String toString() => Constants.serverError;
}

class CacheFailure extends Failure {
  @override
  String toString() => Constants.cacheError;
}

class NetworkFailure extends Failure {
  @override
  String toString() => Constants.networkError;
}

class TimeoutFailure extends Failure {
  final String errorMessage;

  TimeoutFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class FirebaseFailure extends Failure {
  final String errorMessage;

  FirebaseFailure(this.errorMessage);
}

class APIServiceFailure extends Failure {
  final String errorMessage;

  APIServiceFailure(this.errorMessage);
}

class AuthTokenFailure extends Failure {
  final String errorMessage;

  AuthTokenFailure(this.errorMessage);
}

class AuthTokenRefreshFailure extends Failure {
  AuthTokenRefreshFailure();
}

class DatabaseFailure extends Failure {
  final String errorMessage;

  DatabaseFailure(this.errorMessage);
}
