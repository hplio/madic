import 'package:flutter/material.dart';
import 'package:madic/utils/color.dart';

class MadicalCard extends StatelessWidget {
  const MadicalCard({
    super.key,
    required this.containerColor,
    required this.bellColor,
    required this.subTitle,
    required this.whenPillTack,
  });

  final Color? containerColor;
  final Color? bellColor;
  final String subTitle;
  final String whenPillTack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: ragularColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Calpol 500mg Tablet",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("$whenPillTack - Day 01",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: bellColor,
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
