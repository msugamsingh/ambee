import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsets? padding;

  const TextIconButton(
      {Key? key,
      required this.label,
      this.style,
      required this.icon,
      required this.onTap,
      this.iconColor,
      this.iconSize,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          children: [
            Text(
              label,
              style: style,
            ),
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
