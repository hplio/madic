import 'package:flutter/material.dart';
import 'package:madic/screen/widget/madical_card.dart';

class MadicalInfoWidget extends StatelessWidget {
  const MadicalInfoWidget({
    super.key,
    required this.title,
    this.containerColor,
    this.bellColor,
    this.subTitle = 'Taken',
    this.vertical = 8,
    this.children,
    required this.whenPillTack,
  });

  final String title;
  final String subTitle;
  final String whenPillTack;
  final Color? containerColor;
  final Color? bellColor;
  final double vertical;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: vertical),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        MadicalCard(
          whenPillTack: whenPillTack,
          containerColor: containerColor,
          bellColor: bellColor,
          subTitle: subTitle,
        ),
        children != null
            ? Column(
                children: children!,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
