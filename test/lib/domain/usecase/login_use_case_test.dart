import 'package:dartz/dartz.dart';
import 'package:doc_manager/domain/repositories/login_repo.dart';
import 'package:doc_manager/domain/use_case/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepo extends Mock implements LoginRepo {}

void main() {
  late final MockLoginRepo mockLoginRepo;
  late final LoginUseCase SUT;

  setUp(() {
    mockLoginRepo = MockLoginRepo();
    SUT = LoginUseCase(mockLoginRepo);
  });
  String msisdn = '+918618046831';

  test("Should call repository to authenticate User", () async {
    // arrange
    when(mockLoginRepo.authenticateUser(msisdn))
        .thenAnswer((_) async => const Right(true));
    // act
    final result = await SUT(msisdn);
    // assert
    // expect(result, const Right(true));
    verify(mockLoginRepo.authenticateUser(msisdn));
    verifyNoMoreInteractions(mockLoginRepo);
  });
}
