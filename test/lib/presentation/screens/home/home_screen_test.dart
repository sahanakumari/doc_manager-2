import 'package:bloc_test/bloc_test.dart';
import 'package:doc_manager/presentation/bloc/home/home_bloc.dart';
import 'package:doc_manager/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;

class MockHomeBloc extends MockBloc <DoctorsEvent, DoctorsState>
    implements HomeBloc {}

class HomeBlocFake extends Fake implements DoctorsEvent {}

class HomeStateFake extends Fake implements DoctorsState {}

void main() async {
  late MockHomeBloc mockHomeBloc;
  setUpAll(() async {
    mocktail.registerFallbackValue(HomeBlocFake());
    mocktail.registerFallbackValue(HomeStateFake());
  });

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    mocktail.when(() => mockHomeBloc.state).thenReturn((DoctorsInitial()));
  });
  testWidgets('Home Screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
       MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<HomeBloc>(
                create: (context) => MockHomeBloc(),
              ),
            ],
            child: const HomeScreen(),
          ),
        ),
      ),
    );

//verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(WillPopScope), findsNWidgets(1));
    expect(find.byType(Scaffold), findsNWidgets(3));
  });
}
