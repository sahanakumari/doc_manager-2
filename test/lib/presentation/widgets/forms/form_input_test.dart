import 'package:doc_manager/presentation/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('FormInput Screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FormInput(
           label: "text",
            enabled: true,
          ),
        ),
      ),
    );

//verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(Padding), findsNWidgets(1));
  });
}
