import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String iconLink;
  final String text;

  const ActionButton({required this.iconLink, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          iconLink,
          width: 19,
          height: 19,
          color: Colors.grey.shade500,
        ),

        // Icon(icon, color: Colors.grey.shade500, size: 19),
        if (text.isNotEmpty) ...[
          const SizedBox(width: 5),

          Text(
            text,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
