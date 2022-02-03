import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/source/errors/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, bool>> authenticateUser(String msisdn);
}
