// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:proj_src/Screens/Profile/screen_profile.dart';

import 'package:proj_src/main.dart';
import 'package:proj_src/Screens/Chatroom/chatroom.dart';
import 'package:proj_src/Screens/Menu/screen_menu.dart';
import 'package:proj_src/Screens/Chatroom/chatroom.dart';

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
  testWidgets('Menu Page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Screen_Menu()));
    final menu = find.text("MENU PAGE");
    expect(menu, findsOneWidget);
    //expect(find.byType(Scaffold), findsNWidgets(1)); //chatMessages
    //expect(find.byType(Stack), findsOneWidget); //Next
    // expect(find.byType(MaterialButton), findsOneWidget); //Date
    //expect(find.byType(DropDownFormField),
    //findsNWidgets(2)); //District and Category
  });

  testWidgets('Profile Page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Profile()));
    expect(find.byType(Widget), findsNWidgets(3));
    //expect(find.byType(Scaffold), findsNWidgets(1)); //chatMessages
    //expect(find.byType(Stack), findsOneWidget); //Next
    // expect(find.byType(MaterialButton), findsOneWidget); //Date
    //expect(find.byType(DropDownFormField),
    //findsNWidgets(2)); //District and Category
  });
}
