// Basic widget test untuk SmartPOS Green AI.
//
// Test ini memastikan halaman Login tampil sebagai halaman awal aplikasi.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smartpos_green_ai/main.dart';

void main() {
  testWidgets('Halaman Login tampil sebagai halaman awal',
      (WidgetTester tester) async {
    // Build aplikasi dan trigger sebuah frame.
    await tester.pumpWidget(const SmartPosApp());

    // Verifikasi elemen-elemen halaman Login muncul.
    expect(find.text('Masuk ke Akun Anda'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // username & password
  });
}