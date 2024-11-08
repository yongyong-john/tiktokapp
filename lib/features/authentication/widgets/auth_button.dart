import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
          horizontal: Sizes.size10,
        ),
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.grey.shade200,
          width: Sizes.size1,
        )),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
