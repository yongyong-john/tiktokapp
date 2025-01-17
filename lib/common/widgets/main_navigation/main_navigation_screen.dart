import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/features/discover/discover_screen.dart';
import 'package:tiktokapp/features/inbox/inbox_screen.dart';
import 'package:tiktokapp/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktokapp/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktokapp/features/users/user_profile_screen.dart';
import 'package:tiktokapp/features/videos/video_recoding_screen.dart';
import 'package:tiktokapp/features/videos/video_timeline_screen.dart';
import 'package:tiktokapp/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "main_navigation";
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    'home',
    'discover',
    'etc',
    'inbox',
    'profile',
  ];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  final screens = [
    const Center(
      child: Text(
        "Home",
        style: TextStyle(fontSize: 49),
      ),
    ),
    const Center(
      child: Text(
        "Discover",
        style: TextStyle(fontSize: 49),
      ),
    ),
    const Center(
      child: Text(
        "ETC",
        style: TextStyle(fontSize: 49),
      ),
    ),
    const Center(
      child: Text(
        "Inbox",
        style: TextStyle(fontSize: 49),
      ),
    ),
    const Center(
      child: Text(
        "Profile",
        style: TextStyle(fontSize: 49),
      ),
    ),
  ];

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecodingScreen.routeName);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Record video'),
    //       ),
    //     ),
    //     fullscreenDialog: true,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NOTE: virtual keyboard에 의해 main 화면이 찌그러지지 않도록 설정.
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 || isDarkMode(context) ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "User",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 || isDarkMode(context) ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NavTab(
              text: "Home",
              isSelected: _selectedIndex == 0,
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              onTap: () => _onTap(0),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: "Discover",
              isSelected: _selectedIndex == 1,
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              onTap: () => _onTap(1),
              selectedIndex: _selectedIndex,
            ),
            Gaps.h24,
            GestureDetector(
              onTap: _onPostVideoButtonTap,
              child: PostVideoButton(
                inverted: _selectedIndex != 0,
              ),
            ),
            Gaps.h24,
            NavTab(
              text: "Inbox",
              isSelected: _selectedIndex == 3,
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              onTap: () => _onTap(3),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: "Profile",
              isSelected: _selectedIndex == 4,
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              onTap: () => _onTap(4),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
