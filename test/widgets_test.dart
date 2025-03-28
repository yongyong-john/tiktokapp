import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';

void main() {
  group("Form Button Tests", () {
    testWidgets("Enabled State", (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: FormButton(
            disabled: false,
          ),
        ),
      );

      expect(find.text("Next"), findsOneWidget);
      expect(tester.firstWidget<AnimatedDefaultTextStyle>(find.byType(AnimatedDefaultTextStyle)).style.color,
          Colors.white);
    });

    testWidgets("Disabled State", (WidgetTester tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.text("Next"), findsOneWidget);
      expect(tester.firstWidget<AnimatedDefaultTextStyle>(find.byType(AnimatedDefaultTextStyle)).style.color,
          Colors.grey.shade600);
    });

    testWidgets("Disabled State DarkMode", (WidgetTester tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(
            platformBrightness: Brightness.dark,
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(
              disabled: true,
            ),
          ),
        ),
      );
      expect((tester.firstWidget<AnimatedContainer>(find.byType(AnimatedContainer)).decoration as BoxDecoration).color,
          Colors.grey.shade400);
    });

    testWidgets("Disabled State LightMode", (WidgetTester tester) async {
      await tester.pumpWidget(
        Theme(
          data: ThemeData(primaryColor: Colors.amber),
          child: const MediaQuery(
            data: MediaQueryData(
              platformBrightness: Brightness.light,
            ),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: FormButton(
                disabled: false,
              ),
            ),
          ),
        ),
      );
      expect((tester.firstWidget<AnimatedContainer>(find.byType(AnimatedContainer)).decoration as BoxDecoration).color,
          Colors.amber);
    });
  });
}
