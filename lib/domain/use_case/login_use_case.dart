import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/domain/repositories/login_repo.dart';
import 'package:doc_manager/domain/use_case/use_case.dart';

class LoginUseCase extends UseCase<bool, String> {
  final LoginRepo listRepo;

  LoginUseCase(this.listRepo);

  @override
  Future<Either<Failure, bool>> call(String msisdn) =>
      listRepo.authenticateUser(msisdn);
}
