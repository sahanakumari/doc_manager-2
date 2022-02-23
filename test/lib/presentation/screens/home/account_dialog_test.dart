import 'package:doc_manager/presentation/screens/home/account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/mockito.dart';

class MockHiveInterface extends Mock implements HiveInterface{}

void main() async {
  late MockHiveInterface mockHiveInterface;

  setUp(() async {
    mockHiveInterface = MockHiveInterface();
    await setUpTestHive();
  });
  testWidgets('Account Dialog Screen UI test', (WidgetTester tester) async {
    mockHiveInterface.openBox('login');
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AccountDialog(),
        ),
      ),
    );

// verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(Padding), findsNWidgets(5));
    expect(find.byType(Align), findsNWidgets(2));
    expect(find.byType(Text), findsNWidgets(3));
  });
}
