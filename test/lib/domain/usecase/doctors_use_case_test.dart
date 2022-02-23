import 'package:dartz/dartz.dart';
import 'package:doc_manager/domain/repositories/doctor_repo.dart';
import 'package:doc_manager/domain/use_case/doctors_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDoctorRepo extends Mock implements DoctorRepo {}

void main() {
  late final MockDoctorRepo mockDoctorRepo;
  late final DoctorsUseCase SUT;

  setUp(() {
    mockDoctorRepo = MockDoctorRepo();
    SUT = DoctorsUseCase(mockDoctorRepo);
  });

  test("Should call repository to fetch all doctors", () async {
    // arrange
    when(mockDoctorRepo.getDoctors({"": ""}))
        .thenAnswer((_) async => const Right([]));
    // act
    final result = await SUT({"": ""});
    // assert
    verify(mockDoctorRepo.getDoctors({"": ""}));
    verifyNoMoreInteractions(mockDoctorRepo);
  });
}
