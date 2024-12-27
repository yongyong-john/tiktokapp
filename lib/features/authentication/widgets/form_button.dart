import 'package:flutter/material.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/utils.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: disabled ? Colors.grey.shade400 : Theme.of(context).primaryColor,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          style: TextStyle(
            color: disabled
                ? isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade600
                : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: const Text(
            'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
