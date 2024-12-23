import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/authentication/sign_up_screen.dart';
import 'package:tiktokapp/features/main_navigation/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // NOTE: Statusbar의 orientation 설정
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  // NOTE: Statusbar의 색상 설정
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok App',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        scaffoldBackgroundColor: Colors.white,
        // NOTE: 버튼을 눌렀을 때, 반짝이는 효과나 눌리는 효과를 제거하기 위한 옵션
        // 만약, 설정이 먹히지 않으면 해당 위젯에서 직접 설정
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
