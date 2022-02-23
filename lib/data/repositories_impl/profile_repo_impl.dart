import 'package:dartz/dartz.dart';
import 'package:doc_manager/core/services/network_connectivity.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/models/networking.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/data/source/profile_local_source.dart';
import 'package:doc_manager/domain/repositories/profile_repo.dart';
import 'package:flutter/cupertino.dart';



class ProfileRepoImpl extends ProfileRepo {
  final ProfileLocalSource localSource;
  final NetworkConnectivity connectivity;

  ProfileRepoImpl({
    required this.localSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, bool>> saveDoctorData(Doctor doctor) async{
    // TODO: implement saveDoctorData
    if (await connectivity.isConnected) {
      try {
        final bool data = await localSource.saveDoctorData(doctor);
        return Right(data);
      } on ErrorResponse catch (e) {
        return Left(APIServiceFailure(e.errorMessage));
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      debugPrint("internet check");
      return Left(NetworkFailure());
    }
  }
}
