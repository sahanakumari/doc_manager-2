
import 'package:dartz/dartz.dart';
import 'package:doc_manager/core/services/db_helper.dart';
import 'package:doc_manager/core/services/network_connectivity.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/models/networking.dart';
import 'package:doc_manager/data/source/doctor_remote_source.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/domain/repositories/doctor_repo.dart';
import 'package:flutter/cupertino.dart';

class DoctorRepoImpl extends DoctorRepo {
  final DoctorRemoteSource remoteSource;
  final NetworkConnectivity connectivity;
  final DbHelper dbHelper;

  DoctorRepoImpl({
    required this.remoteSource,
    required this.connectivity,
    required this.dbHelper,
  });

  @override
  Future<Either<Failure, List<Doctor>>> getDoctors(
      Map<String, dynamic> params) async {
    if (await connectivity.isConnected) {
      try {
        final List<Doctor> data = await remoteSource.getDoctors(params);
        dbHelper.getDoctors().then((value) {
          for (var element1 in value) {
           int index = data.indexWhere((element) => element.id == element1.id);
           if(index != -1)
             {
              data.removeAt(index);
              data.insert(index, element1);
             }
          }
        });
        return Right(data);
      } on ErrorResponse catch (e) {
        return Left(APIServiceFailure(e.errorMessage));
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      debugPrint("internet check");
      return Left(NetworkFailure());
    }
  }
}
