import 'package:flutter/material.dart';

class DaysContainer extends StatelessWidget {
  const DaysContainer({
    super.key,
    this.onTap,
    this.backgroundColor,
    required this.title,
    this.titleColor,
  });

  final void Function()? onTap;
  final Color? backgroundColor;
  final String title;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 28,
        backgroundColor: backgroundColor,
        child: Text(
          title,
          style: TextStyle(
            color: titleColor,
          ),
        ),
      ),
    );
  }
}
