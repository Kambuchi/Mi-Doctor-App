import 'package:flutter/material.dart';
import '../../../../../utils/dark_mode_extention.dart';

class LabelButton extends StatelessWidget {
  final String label, value;
  final VoidCallback? onPressed;
  const LabelButton({
    Key? key,
    required this.label,
    required this.value,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final iconColor = isDark ? Colors.green : Colors.black45;
    return MaterialButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (onPressed != null)
                Icon(
                  Icons.chevron_right_outlined,
                  size: 25,
                  color: iconColor,
                ),
            ],
          )
        ],
      ),
    );
  }
}
