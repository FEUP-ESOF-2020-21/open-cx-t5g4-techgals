// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/Screens/Initials/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

void main() {
  /*testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });*/

  testWidgets('Login in welcome page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Welcome()));
    expect(find.text("LOG IN"), findsNWidgets(1));
  });

  testWidgets('Signup in welcome page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Welcome()));
    expect(find.text("SIGN UP"), findsNWidgets(1));
  });

/*  testWidgets('shows messages', (WidgetTester tester) async {
    // Populate the mock database.
    final firestore = MockFirestoreInstance();
    await firestore.collection('users').add({
      'username': 'Oscar',
      'interests': ['css'],
      'email': 'oscar@gmail.com'
    });

    // Render the widget.
    await tester.pumpWidget(MaterialApp(
        title: 'Firestore Example', home: DatabaseMethods()));
    // Let the snapshots stream fire a snapshot.
    await tester.idle();
    // Re-render.
    await tester.pump();
    // // Verify the output.
    expect(find.text('Hello world!'), findsOneWidget);
    expect(find.text('Message 1 of 1'), findsOneWidget);
  });*/
}
