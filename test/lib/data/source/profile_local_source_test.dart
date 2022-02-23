import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/source/profile_local_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProfileLocalSource extends Mock implements ProfileLocalSource {}




Future<void> main() async {
  ProfileLocalSourceImpl? SUT;
  MockProfileLocalSource? mockProfileLocalSource;


  setUp(() {
    mockProfileLocalSource = MockProfileLocalSource();


    SUT = ProfileLocalSourceImpl();
  });

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
  // test(
  //   'should return server failure when saveDoctorData is unsuccessful',
  //       () async {
  //     // arrange
  //     when(mockProfileLocalSource!.saveDoctorData(Doctor()))
  //         .thenThrow(ServerFailure());
  //
  //     // assert
  //     expect(() => mockProfileLocalSource!.saveDoctorData(Doctor()),
  //         throwsA(isInstanceOf<ServerFailure>()));
  //   },
  // );
}
