import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/main_navigation/main_navigation_screen.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
    print(details);
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(),
      ),
      (route) {
        print(route);
        return false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v80,
                  Text(
                    'Watch cool videos!',
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you watch, like, and share.',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              secondChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v80,
                  Text(
                    'Follow the rules',
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    'Take care of one another! please!',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              crossFadeState: _showingPage == Page.first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 120,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size24,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              opacity: _showingPage == Page.first ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                onPressed: _onEnterAppTap,
                child: const Text('Enter the app!'),
              ),
            ),
          ),
        ),
      ),
    );
    // return DefaultTabController(
    //   length: 3,
    //   child: Scaffold(
    //     body: const SafeArea(
    //       child: TabBarView(
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: Sizes.size24,
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Gaps.v52,
    //                 Text(
    //                   'Watch cool videos!',
    //                   style: TextStyle(
    //                     fontSize: Sizes.size40,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Gaps.v16,
    //                 Text(
    //                   'Videos are personalized for you based on what you watch, like, and share.',
    //                   style: TextStyle(
    //                     fontSize: Sizes.size20,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: Sizes.size24,
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Gaps.v52,
    //                 Text(
    //                   'Follow the rules',
    //                   style: TextStyle(
    //                     fontSize: Sizes.size40,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Gaps.v16,
    //                 Text(
    //                   'Videos are personalized for you based on what you watch, like, and share.',
    //                   style: TextStyle(
    //                     fontSize: Sizes.size20,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: Sizes.size24,
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Gaps.v52,
    //                 Text(
    //                   'Enjoy the ride',
    //                   style: TextStyle(
    //                     fontSize: Sizes.size40,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Gaps.v16,
    //                 Text(
    //                   'Videos are personalized for you based on what you watch, like, and share.',
    //                   style: TextStyle(
    //                     fontSize: Sizes.size20,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     bottomNavigationBar: BottomAppBar(
    //       height: 140,
    //       color: Colors.white,
    //       child: Container(
    //         padding: const EdgeInsets.symmetric(
    //           vertical: Sizes.size48,
    //         ),
    //         child: const Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             TabPageSelector(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
