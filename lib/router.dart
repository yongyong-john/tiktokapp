import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/videos/video_recoding_screen.dart';

// NOTE: Mobile의 경우 큰 문제가 없지만, Flutter가 Web도 지원하기 때문에
// Browser의 앞으로가기 뒤로가기 버튼이 제대로 동작하기 위해서는 GoRouter를 사용
final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const VideoRecodingScreen(),
    )
  ],
);
