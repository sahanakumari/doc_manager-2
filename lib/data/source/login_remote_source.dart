import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class LoginRemoteSource {
  Future<Map<String, String?>> requestOtpForMsisdn(String msisdn);
}

class LoginRemoteSourceImpl extends LoginRemoteSource {
  final FirebaseAuth firebaseAuth;
  LoginRemoteSourceImpl(
      {required this.firebaseAuth,});

  @override
  Future<Map<String, String?>> requestOtpForMsisdn(String msisdn) async {
    // TODO: implement requestOtpForMsisdn
    final String? _verificationId =
    await getVerificationId(msisdn, firebaseAuth, msisdn);
    if (_verificationId != null) {
      final Map<String, String?> otpDetails = {
        'verification_id': _verificationId,
        'msisdn': msisdn,
      };
      return otpDetails;
    } else {
      throw Exception("Error......");
    }
  }


  Future<String?> getVerificationId(String msisdn, FirebaseAuth firebaseAuth,
      String? uuid) async {
    try {
      String? _verificationId;
      var futureVerificationId = Completer<String>();

      void verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
        //This implements auto login without user clicking on VerifyAccount button
        // await firebaseAuth.signInWithCredential(phoneAuthCredential);
      }

      void verificationFailed(FirebaseAuthException authException) {
        debugPrint('firebase error :: ${authException.message}');
        debugPrint('firebase error code :: ${authException.code}');
        if (authException.code == 'missing-client-identifier') {
          _verificationId = 'missing-client-identifier';
          futureVerificationId.complete(_verificationId);
        } else if (authException.code == 'operation-not-allowed') {
          _verificationId = 'operation-not-allowed';
          futureVerificationId.complete(_verificationId);
        } else if (authException.code == 'invalid-phone-number') {
          _verificationId = 'invalid-phone-number';
          futureVerificationId.complete(_verificationId);
        } else if (authException.code == 'too-many-requests') {
          _verificationId = 'too-many-requests';
          futureVerificationId.complete(_verificationId);
        }
      }

      void codeSent(String verificationId, [int? forceResendingToken]) async {
        _verificationId = verificationId;
        debugPrint('_verificationId');
        futureVerificationId.complete(_verificationId);
      }

      void codeAutoRetrievalTimeout(String verificationId) {
        _verificationId = verificationId;
      }

      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: msisdn,
          timeout: const Duration(minutes: 2),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

      return futureVerificationId.future;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw Exception();
    }
  }
}