import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/haptic_service.dart';

class EnhancedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final bool outlined;
  final Size? minimumSize;

  const EnhancedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
    this.textColor,
    this.outlined = false,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    final button = icon != null
        ? (outlined
            ? OutlinedButton.icon(
                onPressed: _handlePress,
                icon: Icon(icon),
                label: Text(label),
                style: _getOutlinedStyle(context),
              )
            : ElevatedButton.icon(
                onPressed: _handlePress,
                icon: Icon(icon),
                label: Text(label),
                style: _getElevatedStyle(context),
              ))
        : (outlined
            ? OutlinedButton(
                onPressed: _handlePress,
                style: _getOutlinedStyle(context),
                child: Text(label),
              )
            : ElevatedButton(
                onPressed: _handlePress,
                style: _getElevatedStyle(context),
                child: Text(label),
              ));

    return button
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(delay: 100.ms, duration: 200.ms);
  }

  void _handlePress() {
    HapticService().light();
    onPressed();
  }

  ButtonStyle _getElevatedStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: textColor ?? Colors.white,
      minimumSize: minimumSize ?? const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
    );
  }

  ButtonStyle _getOutlinedStyle(BuildContext context) {
    return OutlinedButton.styleFrom(
      foregroundColor: color ?? Theme.of(context).primaryColor,
      minimumSize: minimumSize ?? const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      side: BorderSide(
        color: color ?? Theme.of(context).primaryColor,
        width: 2,
      ),
    );
  }
}
