import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/domain/use_case/profile_use_case.dart';
import 'package:doc_manager/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockProfileUseCase extends Mock implements ProfileUseCase{}

void main() {
  group('profile bloc test', () {
    ProfileBloc? SUT;
    MockProfileUseCase? mockProfileUseCase;
    setUp(() {
      mockProfileUseCase = MockProfileUseCase();
      SUT = ProfileBloc(mockProfileUseCase!,);
    });
    final Doctor _doctor = Doctor(
        id: 123,
        firstName: 'Max',
        lastName: 'kumar',
        email: 'maxkumar@gmail.com',
        height: '5.5',
        bloodGroup: 'B +',
        description: 'special doctor',
        dob: '3-04-2006',
        gender: 'female',
        primaryContactNo: '+91861804634',
        weight: '40',
        isFavourite: true,
        languagesKnown: 'english',
        qualification: 'bca',
        rating: '5',
        specialization: 'heart specialization'
    );


    test('should load profile bloc Initial State', () {
      expect(SUT!.state.runtimeType, ProfileInitial);
    });

    blocTest(
      'should send a request to dependent usecase and load profilebloc LoadedState ',
      build: () => SUT!,
      act: (ProfileBloc profileBloc) async {
        when(mockProfileUseCase!.call(_doctor))
            .thenAnswer((_) async =>  const Right(false));
        profileBloc.add( SaveData(_doctor));
      },
      expect: () => [
        DataLoading(),
        DataLoaded()
      ],
    );

    tearDown(() {
      SUT!.close();
    });
  });
}
