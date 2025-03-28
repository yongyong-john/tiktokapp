import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiktokapp/firebase_options.dart';
import 'package:tiktokapp/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.signOut();
  });

  testWidgets("Create Account Flow", (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TikTokApp(),
      ),
    );
    // NOTE: pumpAndSettle는 애니메이션이나 화면 전환 등으로 나오는 프레임은 넘어가고 최종 프레임을 랜더링.
    await tester.pumpAndSettle();

    expect(find.text("Sign up for Tiktok"), findsOneWidget);
    final logIn = find.text("Log in");
    expect(logIn, findsOneWidget);
    await tester.tap(logIn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final signUp = find.text("Sign up");
    expect(signUp, findsOneWidget);
    await tester.tap(signUp);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final emailBtn = find.text('Use email & password');
    expect(emailBtn, findsOneWidget);
    await tester.tap(emailBtn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final usernameInput = find.byType(TextField).first;
    await tester.enterText(usernameInput, "tester");
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final emailInput = find.byType(TextField).first;
    await tester.enterText(emailInput, "test@testing.com");
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final passwordInput = find.byType(TextField).first;
    await tester.enterText(passwordInput, "test1234!@");
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 10));
    // TODO: 테스트 시 expect를 사용하고 예외처리를 추가
  });
}
