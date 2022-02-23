import 'package:bloc_test/bloc_test.dart';
import 'package:doc_manager/presentation/bloc/login/login_bloc.dart';
import 'package:doc_manager/presentation/screens/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import '../../../mock1.dart';

class MockHiveInterface extends Mock implements HiveInterface{}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class LoginBlocFake extends Fake implements LoginEvent {}

class LoginStateFake extends Fake implements LoginState {}

void main() async {
  late MockLoginBloc mockLoginBloc;
  late MockHiveInterface mockHiveInterface;
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
    mockHiveInterface = MockHiveInterface();
    await setUpTestHive();
    mocktail.registerFallbackValue(LoginBlocFake());
    mocktail.registerFallbackValue(LoginStateFake());
  });

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    mocktail.when(() => mockLoginBloc.state).thenReturn(LoginInitial());
  });

  testWidgets('Login Screen Input UI test', (WidgetTester tester) async {
    mockHiveInterface.openBox('login');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) => MockLoginBloc(),
              ),
            ],
            child: const LoginScreen(),
          ),
        ),
      ),
    );

    // verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(SafeArea), findsNWidgets(1));
     expect(find.byType(SafeArea), findsNWidgets(1));
     expect(find.byType(Center), findsNWidgets(1));
  });
  //});
}
