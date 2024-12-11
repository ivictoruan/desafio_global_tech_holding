import 'package:flutter/material.dart';

class FeatureCardWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? backgroundColor;

  const FeatureCardWidget({
    super.key,
    required this.icon,
    required this.label,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
