import 'package:final_project/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.isActive,
    this.width,
    this.height,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final bool isActive;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: AppColors.inactive,
          foregroundColor: AppColors.textPrimary,
          disabledForegroundColor: AppColors.textWhite,
        ),
        child: Text(text),
      ),
    );
  }
}