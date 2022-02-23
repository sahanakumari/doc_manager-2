import 'package:doc_manager/presentation/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('Rating Bar Screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RatingBar(
            rating: 1,
            color: Color(0xffffc107),
            size: 1,
          ),
        ),
      ),
    );

//verify that the widgets appear exactly these number of times in the widget tree.
    expect(find.byType(Icon), findsNWidgets(5));

  });
}
