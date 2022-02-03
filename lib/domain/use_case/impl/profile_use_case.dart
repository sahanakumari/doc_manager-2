import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/domain/repositories/profile_repo.dart';
import 'package:doc_manager/domain/use_case/core/use_case.dart';

class ProfileUseCase extends UseCase<bool, Doctor> {
  final ProfileRepo profileRepo;

  ProfileUseCase(this.profileRepo);

  @override
  Future<Either<Failure, bool>> call(Doctor doctor) =>
      profileRepo.saveDoctorData(doctor);
}