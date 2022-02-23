import 'package:doc_manager/presentation/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('Error Container Screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ErrorContainer(
            title: "error",
            buttonText: "text",
            subtitle: 'des',
          ),
        ),
      ),
    );

//verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(Align), findsNWidgets(1));
  });
}
