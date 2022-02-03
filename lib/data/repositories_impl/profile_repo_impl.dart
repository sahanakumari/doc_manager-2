import 'package:dartz/dartz.dart';
import 'package:doc_manager/core/utils/network_n_storage/network_connectivity.dart';
import 'package:doc_manager/core/utils/network_n_storage/networking.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/data/source/profile_local_source.dart';
import 'package:doc_manager/domain/repositories/profile_repo.dart';



class ProfileRepoImpl extends ProfileRepo {
  final ProfileLocalSource remoteSource;
  final NetworkConnectivity connectivity;

  ProfileRepoImpl({
    required this.remoteSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, bool>> saveDoctorData(Doctor doctor) async{
    // TODO: implement saveDoctorData
    if (await connectivity.isConnected) {
      try {
        final bool data = await remoteSource.saveDoctorData(doctor);
        return Right(data);
      } on ErrorResponse catch (e) {
        return Left(APIServiceFailure(e.errorMessage));
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
