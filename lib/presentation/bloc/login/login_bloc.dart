import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:doc_manager/core/utils/constants.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/domain/use_case/impl/login_use_case.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc({required this.loginUseCase}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AuthenticateUserEvent) {
      yield* _mapToState(event);
    }
  }

  Stream<LoginState> _mapToState(AuthenticateUserEvent event) async* {

    final failureOrAuthStatus = await loginUseCase(event.msisdn);
    yield failureOrAuthStatus.fold(
          (failure) => LoginError(_failureToString(failure)),
          (data) => UserAuthenticated(),
    );
  }

  String _failureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
      case CacheFailure:
        return Constants.cacheError.toString();
      default:
        return Constants.unknownError;
    }
  }
}
