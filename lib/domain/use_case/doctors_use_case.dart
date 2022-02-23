import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/domain/repositories/doctor_repo.dart';
import 'package:doc_manager/domain/use_case/use_case.dart';

class DoctorsUseCase extends UseCase<List<Doctor>, Map<String, dynamic>> {
  final DoctorRepo listRepo;

  DoctorsUseCase(this.listRepo);

  @override
  Future<Either<Failure, List<Doctor>>> call(Map<String, dynamic> params) =>
      listRepo.getDoctors(params);
}
