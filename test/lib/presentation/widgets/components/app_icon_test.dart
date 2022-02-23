import 'package:doc_manager/presentation/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('AppIcon Screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppIcon(
            size: 6.5,
            foregroundColor: Colors.red,
            backgroundColor: Colors.amber,
          ),
        ),
      ),
    );

// verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(Padding), findsNWidgets(1));
  });
}
