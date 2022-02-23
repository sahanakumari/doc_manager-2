import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/domain/use_case/doctors_use_case.dart';
import 'package:doc_manager/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockDoctorsUseCase extends Mock implements DoctorsUseCase{}

void main() {
  group('home bloc test', () {
    HomeBloc? SUT;
    MockDoctorsUseCase? mockDoctorsUseCase;
    setUp(() {
      mockDoctorsUseCase = MockDoctorsUseCase();
      SUT = HomeBloc(
          doctorsUseCase: mockDoctorsUseCase!,
      );
    });

    test('should load home bloc Initial State', () {
      expect(SUT!.state.runtimeType, DoctorsInitial);
    });

    blocTest(
      'should send a request to dependent usecase and load homebloc LoadedState ',
      build: () => SUT!,
      act: (HomeBloc homeBloc) async {
        when(mockDoctorsUseCase!.call({"": ""}))
            .thenAnswer((_) async =>  Right([Doctor()]));
        homeBloc.add(const GetDoctorsListEvent({"": ""}));
      },
      expect: () => [
        DoctorsLoading(),
         DoctorsLoaded([Doctor()],false)
      ],
    );

    tearDown(() {
      SUT!.close();
    });
  });
}
