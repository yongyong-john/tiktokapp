import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktokapp/features/authentication/login_screen.dart';
import 'package:tiktokapp/features/authentication/sign_up_screen.dart';
import 'package:tiktokapp/features/inbox/activity_screen.dart';
import 'package:tiktokapp/features/inbox/chat_detail_screen.dart';
import 'package:tiktokapp/features/inbox/chats_screen.dart';
import 'package:tiktokapp/features/onboarding/interests_screen.dart';
import 'package:tiktokapp/features/videos/views/video_recoding_screen.dart';

// NOTE: Mobile의 경우 큰 문제가 없지만, Flutter가 Web도 지원하기 때문에
// Browser의 앞으로가기 뒤로가기 버튼이 제대로 동작하기 위해서는 GoRouter를 사용
final router = GoRouter(
  initialLocation: '/inbox',
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: "/:tab(home|discover|inbox|profile)",
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      name: ActivityScreen.routeName,
      path: ActivityScreen.routeURL,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
      name: ChatsScreen.routeName,
      path: ChatsScreen.routeURL,
      builder: (context, state) => const ChatsScreen(),
      routes: [
        GoRoute(
          name: ChatDetailScreen.routeName,
          path: ChatDetailScreen.routeURL,
          builder: (context, state) {
            final id = state.params["chatId"]!;
            return ChatDetailScreen(chatId: id);
          },
        ),
      ],
    ),
    GoRoute(
      name: VideoRecodingScreen.routeName,
      path: VideoRecodingScreen.routeURL,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 200),
        child: const VideoRecodingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final position = Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: position,
            child: child,
          );
        },
      ),
    ),
  ],
);
