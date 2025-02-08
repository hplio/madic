import 'package:flutter/material.dart';
import 'package:madic/utils/color.dart';

class SletectWidgetContainr extends StatelessWidget {
  const SletectWidgetContainr({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  final String title;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? selectedColor : ragularColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
