import 'package:dartz/dartz.dart';
import 'package:doc_manager/core/utils/network_n_storage/db_helper.dart';
import 'package:doc_manager/core/utils/network_n_storage/network_connectivity.dart';
import 'package:doc_manager/core/utils/network_n_storage/networking.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/data/source/doctor_remote_source.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/domain/repositories/doctor_repo.dart';




class DoctorRepoImpl extends DoctorRepo {
  final DoctorRemoteSource remoteSource;
  final NetworkConnectivity connectivity;

  DoctorRepoImpl({
    required this.remoteSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, List<Doctor>>> getDoctors(
      Map<String, dynamic> params) async {
    if (await connectivity.isConnected) {
      try {
        final List<Doctor> data = await remoteSource.getDoctors(params);
        var copy = [];
        copy.addAll(data);
        DbHelper().getDoctors().then((value) {
          data.clear();
          for (var e in copy) {
            var doc = e;
            for (var element in value) {
              if (e == element) {
                doc = element;
              }
            }
            data.add(doc);
          }
        });

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
