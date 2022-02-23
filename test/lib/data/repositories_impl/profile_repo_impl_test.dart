import 'package:doc_manager/core/services/network_connectivity.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/repositories_impl/profile_repo_impl.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/data/source/profile_local_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProfileLocalSource extends Mock implements ProfileLocalSource {}

class MockNetworkInfo extends Mock implements NetworkConnectivity {}


Future<void> main() async {
  ProfileRepoImpl? SUT;
  MockProfileLocalSource? mockProfileLocalSource;
  MockNetworkInfo? mockNetworkInfo;



  setUp(() {
    mockProfileLocalSource = MockProfileLocalSource();
    mockNetworkInfo = MockNetworkInfo();

    SUT = ProfileRepoImpl(
      localSource: mockProfileLocalSource!,
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
        'should save list of doctors when saveDoctorData is successful',
            () async {
          // arrange
          when(mockProfileLocalSource!.saveDoctorData(Doctor()))
              .thenAnswer((_) async => true);

          // act
          await SUT!.saveDoctorData(Doctor());
          // assert
          verify(mockProfileLocalSource!.saveDoctorData(Doctor()));
        },
      );

      test(
        'should return server failure when saveDoctorData is unsuccessful',
            () async {
          // arrange
          when(mockProfileLocalSource!.saveDoctorData(Doctor()))
              .thenThrow(ServerFailure());

          // assert
          expect(() => mockProfileLocalSource!.saveDoctorData(Doctor()),
              throwsA(isInstanceOf<ServerFailure>()));
        },
      );
    });
  });
}
