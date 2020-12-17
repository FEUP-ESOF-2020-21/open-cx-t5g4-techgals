// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proj_src/Screens/Initials/welcome.dart';

void main() {
  testWidgets('Login in welcome page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Welcome()));
    expect(find.text("LOG IN"), findsNWidgets(1));
  });

  testWidgets('Signup in welcome page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Welcome()));
    expect(find.text("SIGN UP"), findsNWidgets(1));
  });
}
