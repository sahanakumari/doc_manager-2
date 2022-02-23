
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/presentation/widgets/doctor_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  final _items = Doctor();
  testWidgets('DoctorListTile Screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DoctorListTile(
            heroTag: 'tag',
            item: _items,

          ),
        ),
      ),
    );

//verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(ListTile), findsNWidgets(1));

  });
}
