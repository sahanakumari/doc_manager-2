import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doc_manager/domain/use_case/login_use_case.dart';
import 'package:doc_manager/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockLoginUseCase extends Mock implements LoginUseCase{}

void main() {
  group(' login bloc test', () {
    LoginBloc? SUT;
    MockLoginUseCase? mockLoginUseCase;
    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      SUT = LoginBloc(
         loginUseCase: mockLoginUseCase!,
      );
    });

    test('should load home bloc Initial State', () {
      expect(SUT!.state.runtimeType, LoginInitial);
    });

    blocTest(
      'should send a request to dependent usecase and load loginBloc LoadedState ',
      build: () => SUT!,
      act: (LoginBloc loginBloc) async {
        when(mockLoginUseCase!.call('+918618046831'))
            .thenAnswer((_) async =>  const Right(true));
        loginBloc.add( AuthenticateUserEvent('+918618046831'));
      },
      expect: () =>
        [SUT?.state as UserAuthenticated],
    );

    tearDown(() {
      SUT!.close();
    });
  });
}
