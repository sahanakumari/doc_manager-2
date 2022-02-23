import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/source/errors/failure.dart';


abstract class DoctorRepo {
  Future<Either<Failure, List<Doctor>>> getDoctors(Map<String, dynamic> params);
}
