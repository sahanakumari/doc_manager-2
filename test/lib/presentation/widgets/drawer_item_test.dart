
import 'package:doc_manager/presentation/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('DrawerItem Screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DrawerItem(
            label: 'text',
            isSelected: true,
            icon: Icons.ac_unit,
          ),
        ),
      ),
    );

//verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(InkWell), findsNWidgets(1));
  });
}
