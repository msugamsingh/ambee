import 'package:ambee/utils/values/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final int? maxLength;
  final String? errorText;
  final int? maxLines;
  final void Function(String s)? onChanged;

  const CustomTextField(
      {Key? key,
      this.controller,
      required this.label,
      required this.hint,
      this.maxLength,
      this.errorText,
      this.maxLines,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: Text(label),
        errorText: errorText,
        hintText: hint,
        contentPadding: const EdgeInsets.all(
          12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.white38
                : AppColors.bgColor38,
          ),
          borderRadius: BorderRadius.circular(
            14.0,
          ),
        ),
      ),
      autofocus: true,
      onChanged: onChanged,
    );
  }
}
