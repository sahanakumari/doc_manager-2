import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/domain/repositories/profile_repo.dart';
import 'package:doc_manager/domain/use_case/profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

void main() {
  late final MockProfileRepo mockProfileRepo;
  late final ProfileUseCase SUT;

  setUp(() {
    mockProfileRepo = MockProfileRepo();
    SUT = ProfileUseCase(mockProfileRepo);
  });

  test("Should call repository to save doctor data", () async {
    // arrange
    when(mockProfileRepo.saveDoctorData(Doctor()))
        .thenAnswer((_) async => const Right(true));
    // act
    final result = await SUT(Doctor());
    // assert
    // expect(result, const Right(true));
    verify(mockProfileRepo.saveDoctorData(Doctor()));
    verifyNoMoreInteractions(mockProfileRepo);
  });
}
