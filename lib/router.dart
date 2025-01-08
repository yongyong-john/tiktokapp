import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/email_screen.dart';
import 'package:tiktokapp/features/authentication/login_screen.dart';
import 'package:tiktokapp/features/authentication/sign_up_screen.dart';
import 'package:tiktokapp/features/authentication/username_screen.dart';
import 'package:tiktokapp/features/users/user_profile_screen.dart';

// NOTE: Mobile의 경우 큰 문제가 없지만, Flutter가 Web도 지원하기 때문에
// Browser의 앞으로가기 뒤로가기 버튼이 제대로 동작하기 위해서는 GoRouter를 사용
final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      // NOTE: Nested routes를 사용하여 /signup/username 과 같이 쉽게 사용하도록 함
      routes: [
        GoRoute(
          name: UsernameScreen.routeName,
          path: UsernameScreen.routeURL,
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              name: EmailScreen.routeName,
              path: EmailScreen.routeName,
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(username: args.username);
              },
            ),
          ],
        ),
      ],
    ),
    // GoRoute(
    //   path: LoginScreen.routeName,
    //   builder: (context, state) => const LoginScreen(),
    // ),
    // GoRoute(
    //   // name을 추가해서 pushNamed, goNamed를 사용할 수 있음
    //   // name: 'username_screen',
    //   path: UsernameScreen.routeName,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       child: const UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: ScaleTransition(
    //             scale: animation,
    //             child: child,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: EmailScreen.routeName,
    //   builder: (context, state) {
    //     final args = state.extra as EmailScreenArgs;
    //     return EmailScreen(username: args.username);
    //   },
    // ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        print(state.params);
        final username = state.params['username'];
        final tab = state.queryParams['show'];
        return UserProfileScreen(username: username!, tab: tab!);
      },
    ),
  ],
);
