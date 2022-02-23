import 'package:doc_manager/core/services/networking.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/source/doctor_remote_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';




class MockNetworking extends Mock implements Networking{}

@GenerateMocks([Networking])

Future<void> main() async {
   MockNetworking? mockNetworking;



  setUp(() {
    mockNetworking = MockNetworking();
  });


  test("Should call remote data source to fetch all doctors", () async {
    // arrange
    when(mockNetworking?.get(
      "/contacts",
      enableCaching: false,
      queryParams: {}
    ))
        .thenAnswer((_) async => [Doctor()] );
    // act
     final result =   await  mockNetworking?.get(
         "/contacts",
         enableCaching: false,
         queryParams: {});
    // assert
     expect(result,  [Doctor()]);
    verify(mockNetworking?.get( "/contacts",
      enableCaching: false,queryParams:{} ));
    verifyNoMoreInteractions(mockNetworking);
  });



}
