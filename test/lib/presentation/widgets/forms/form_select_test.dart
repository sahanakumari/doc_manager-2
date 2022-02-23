import 'package:doc_manager/presentation/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('FormSelect Screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FormSelect(
           items: [],
            label: 'text',

          ),
        ),
      ),
    );

  });
}
