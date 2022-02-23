import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/presentation/screens/home/doc_carousel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/mockito.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

void main() async {
  late MockHiveInterface mockHiveInterface;
  setUp(() async {
    mockHiveInterface = MockHiveInterface();
    await setUpTestHive();
  });

  var doc = Doctor(
      id: 123,
      firstName: 'Max',
      lastName: 'kumar',
      email: 'maxkumar@gmail.com',
      height: '5.5',
      bloodGroup: 'B +',
      description: 'special doctor',
      dob: '3-04-2006',
      gender: 'female',
      primaryContactNo: '861804634',
      weight: '40',
      isFavourite: true,
      languagesKnown: 'english',
      qualification: 'bca',
      rating: '5',
      specialization: 'heart specialization');

  final List<Doctor> doctorList = List.generate(2, (index) => doc);

  testWidgets('DocCarousel Screen UI test', (WidgetTester tester) async {
    debugPrint("${doctorList.length}");
    mockHiveInterface.openBox('login');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DocCarouselPage(
            doctorList: doctorList,
          ),
        ),
      ),
    );

    /// verify that each doctor details appear once in the [DocCarouselPage].
    expect(find.text(doctorList[0].name), findsNWidgets(doctorList.length));

    ///verify that the widgets appear exactly these number of times in the widget tree
    expect(find.byType(Card), findsNWidgets(doctorList.length));
  });
}
