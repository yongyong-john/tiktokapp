import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        indicatorColor: Theme.of(context).appBarTheme.backgroundColor,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
        dividerHeight: 0.5,
        tabs: const [
          // NOTE: 각 Icon의 Padding으로 인해 indicator의 width가 label보다 길게 보이도록 설정
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: Icon(
              Icons.grid_4x4_rounded,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: FaIcon(
              FontAwesomeIcons.heart,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
