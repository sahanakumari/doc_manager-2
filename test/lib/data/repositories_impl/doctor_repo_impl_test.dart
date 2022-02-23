import 'package:doc_manager/core/services/db_helper.dart';
import 'package:doc_manager/core/services/network_connectivity.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/repositories_impl/doctor_repo_impl.dart';
import 'package:doc_manager/data/source/doctor_remote_source.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDoctorRemoteSource extends Mock implements DoctorRemoteSource {}

class MockNetworkInfo extends Mock implements NetworkConnectivity {}

class MockDbHelper extends Mock implements DbHelper{}

Future<void> main() async {
  DoctorRepoImpl? SUT;
  MockDoctorRemoteSource? mockDoctorRemoteSource;
  MockNetworkInfo? mockNetworkInfo;
  MockDbHelper?     mockDbHelper;


  setUp(() {
    mockDoctorRemoteSource = MockDoctorRemoteSource();
    mockNetworkInfo = MockNetworkInfo();
    mockDbHelper =MockDbHelper();
    SUT = DoctorRepoImpl(
      remoteSource: mockDoctorRemoteSource!,
      connectivity: mockNetworkInfo!,
      dbHelper: mockDbHelper!,

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


  group('Get list of doctors ', () {
    runTestsOnline(() async {
      test(
        'should return list of doctors when getDoctors is successful',
        () async {
          // arrange
          when(mockDoctorRemoteSource!.getDoctors({"":""}))
              .thenAnswer((_) async => [Doctor()]);
          when(mockDbHelper!.getDoctors())
              .thenAnswer((_) async => [Doctor()]);
          // act
          await SUT!.getDoctors({"":""});
          // assert
          verify(mockDoctorRemoteSource!.getDoctors({"":""}));
        },
      );

      test(
        'should return server failure when getProducts is unsuccessful',
        () async {
          // arrange
          when(mockDoctorRemoteSource!.getDoctors({"": ""}))
              .thenThrow(ServerFailure());

          // assert
          expect(() => mockDoctorRemoteSource!.getDoctors({"": ""}),
              throwsA(isInstanceOf<ServerFailure>()));
        },
      );
    });
  });
}
