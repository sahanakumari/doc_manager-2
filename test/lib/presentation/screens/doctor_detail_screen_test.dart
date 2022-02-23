import 'package:bloc_test/bloc_test.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/presentation/bloc/profile/profile_bloc.dart';
import 'package:doc_manager/presentation/screens/doctor_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart' as mocktail;



class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class ProfileBlocFake extends Fake implements ProfileEvent {}

class   ProfileStateFake extends Fake implements ProfileState {}

void main() async {
  late MockProfileBloc mockProfileBloc;


  setUpAll(() async {
    await setUpTestHive();
    mocktail.registerFallbackValue(ProfileBlocFake());
    mocktail.registerFallbackValue(ProfileStateFake());
  });

  setUp(() {
    mockProfileBloc = MockProfileBloc();
    mocktail.when(() => mockProfileBloc.state).thenReturn(ProfileInitial());
  });

  final Doctor doctorList = Doctor();

  testWidgets('Doctor detail Screen Input UI test', (WidgetTester tester) async {


    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ProfileBloc>(
              create: (context) => MockProfileBloc(),
            ),
          ],
          child:DoctorDetailsScreen(doctor: doctorList,),
        ),
      ),
    );


    //verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(Scaffold), findsNWidgets(1));
  });
  //});
}
