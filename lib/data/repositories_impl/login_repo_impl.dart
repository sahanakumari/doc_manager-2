import 'package:dartz/dartz.dart';
import 'package:doc_manager/core/utils/network_n_storage/network_connectivity.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/data/source/login_remote_source.dart';
import 'package:doc_manager/domain/repositories/login_repo.dart';
import 'package:doc_manager/presentation/screens/login_screen.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginRepoImpl extends LoginRepo {
  final LoginRemoteSource remoteSource;
  final NetworkConnectivity connectivity;

  LoginRepoImpl({
    required this.remoteSource,
    required this.connectivity,
  });

  @override
  Future<Either<Failure, bool>> authenticateUser(String msisdn) async {
    if (await connectivity.isConnected) {
      try {
        final msisdnDetails = await remoteSource.requestOtpForMsisdn("+91" + msisdn);
        if (msisdnDetails['verification_id'] == 'missing-client-identifier') {
          return Left(FirebaseFailure(
              'Unable to verify device security. Try again later.'));
        } else if (msisdnDetails['verification_id'] == 'invalid-phone-number') {
          return Left(FirebaseFailure('Invalid phone number!'));
        } else if (msisdnDetails['verification_id'] ==
            'operation-not-allowed') {
          return Left(
              FirebaseFailure('Too many requests to log into this account.'));
        } else if (msisdnDetails['verification_id'] == 'too-many-requests') {
          return Left(FirebaseFailure(
              'We have blocked all requests from this device due to unusual activity. Try again later.'));
        }
        verificationId = msisdnDetails['verification_id'] ?? "" ;
        return const Right(true);
      } on FirebaseAuthException catch (e) {
        debugPrint(e.code);
        debugPrint('firebase error :: ${e.message}');
        if (e.code == 'operation-not-allowed') {
          return Left(
              FirebaseFailure('Too many requests to log into this account.'));
        } else if (e.code == 'invalid-phone-number') {
          return Left(FirebaseFailure('Invalid phone number!'));
        } else if (e.code == 'too-many-requests') {
          return Left(FirebaseFailure(
              'request blocked due to unusual activity. Try again later.'));
        } else if (e.code == 'missing-client-identifier') {
          return Left(FirebaseFailure(
              'Unable to verify device security. Try again later.'));
        } else {
          return Left(
              FirebaseFailure('Something went wrong, Pleaase try again!'));
        }
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      debugPrint("internet check");
      return Left(NetworkFailure());
    }
  }
}
