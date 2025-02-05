// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petmate/main.dart';

void main() {
  testWidgets('App launches correctly and shows the appropriate screen', (WidgetTester tester) async {
    // Case 1: User is NOT logged in (should show IntroPage)
    await tester.pumpWidget(const MyApp(isLoggedIn: false, userId: null));

    // Verify IntroPage is displayed
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Welcome to PetMate!'), findsOneWidget);

    // Case 2: User is logged in (should show Home page)
    await tester.pumpWidget(const MyApp(isLoggedIn: true, userId: 'testUserId'));

    // Verify Home screen is displayed
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Welcome to Home Page!'), findsOneWidget);
  });
}