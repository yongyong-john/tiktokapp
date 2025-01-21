import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/videos/repos/playback_config_repo.dart';
import 'package:tiktokapp/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktokapp/router.dart';
// i18n for Flutter
// https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#messages-with-numbers-and-currencies
import 'package:tiktokapp/generated/l10n.dart';

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

  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlaybackConfigViewModel(repository),
        ),
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    // S.load(const Locale("en"));

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'TikTok App',
      // NOTE: AppLocalizations.localizationsDelegates에 아래의 delegate가 모두 포함됨
      // intl 폴더 설정 후, 'flutter gen-l10n' 명령어를 실행
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      themeMode: ThemeMode.system,
      // NOTE: Theme을 설정하기 쉽게 "flex_color_scheme" package를 사용할 수 있음
      theme: ThemeData(
        brightness: Brightness.light,
        // NOTE: InheritedWidget으로 위젯 트리 맨 위에 정의 된 값을 사용할 수 있음
        // primaryColor는 대표적인 예시
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade50,
        ),
        // NOTE: 아래 링크의 문서인 The type system에서 폰트 설정을 할 수 있음
        // https://m2.material.io/design/typography/the-type-system.html#type-scale
        // GoogleFonts 대신 Typography를 쓰는 것도 방법
        textTheme: Typography.blackMountainView,
        scaffoldBackgroundColor: Colors.white,
        // NOTE: 버튼을 눌렀을 때, 반짝이는 효과나 눌리는 효과를 제거하기 위한 옵션
        // 만약, 설정이 먹히지 않으면 해당 위젯에서 직접 설정
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorColor: Colors.black,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          backgroundColor: Colors.grey.shade900,
          surfaceTintColor: Colors.grey.shade900,
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade800,
        ),
        textTheme: Typography.whiteMountainView,
      ),
    );
  }
}
