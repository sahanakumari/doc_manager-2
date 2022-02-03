import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/data/source/errors/failure.dart';


abstract class ProfileRepo {
  Future<Either<Failure, bool>> saveDoctorData(Doctor doctor);
}
