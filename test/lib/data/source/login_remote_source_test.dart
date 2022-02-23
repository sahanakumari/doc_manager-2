import 'package:doc_manager/core/services/network_connectivity.dart';
import 'package:doc_manager/data/repositories_impl/login_repo_impl.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/data/source/login_remote_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginRemoteSource extends Mock implements LoginRemoteSource {}

class MockNetworkInfo extends Mock implements NetworkConnectivity {}


void  main() async {

  LoginRepoImpl? SUT;
  MockLoginRemoteSource? mockLoginRemoteSource;
  MockNetworkInfo? mockNetworkInfo;



  setUp(() {
    mockLoginRemoteSource = MockLoginRemoteSource();
    mockNetworkInfo = MockNetworkInfo();

    SUT = LoginRepoImpl(
      remoteSource: mockLoginRemoteSource!,
      connectivity: mockNetworkInfo!,


    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }


  group(' save doctor data ', () {
    runTestsOnline(() async {
      test(
        'should save list of doctors when requestOtpForMsisdn is successful',
            () async {
          // arrange
          when(mockLoginRemoteSource!.requestOtpForMsisdn('+918618046831')).
          thenAnswer((_) async =>  {"verification_id":"invalid-phone-number"});

          // act
          await SUT!.authenticateUser('8618046831');
          // assert
          verify(mockLoginRemoteSource!.requestOtpForMsisdn('+918618046831'));
        },
      );

      test(
        'should return server failure when saveDoctorData is unsuccessful',
            () async {
          // arrange
          when(mockLoginRemoteSource!.requestOtpForMsisdn('+918618046831'))
              .thenThrow(ServerFailure());

          // assert
          expect(() => mockLoginRemoteSource!.requestOtpForMsisdn('+918618046831'),
              throwsA(isInstanceOf<ServerFailure>()));
        },
      );
    });
  });
}
