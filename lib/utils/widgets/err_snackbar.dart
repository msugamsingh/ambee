import 'package:ambee/data/network/network_error_messages.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:flutter/material.dart';

// Shows snacbar based on the context
void onError({
  required BuildContext context,
  String? message,
  SnackBarAction? action,
  int? seconds,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.bgColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        duration: Duration(seconds: seconds ?? 5),
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message ?? ErrorMessages.networkGeneral,
            style: Styles.tsRegularBodyText.copyWith(color: AppColors.white)
          ),
        ),
        action: action,
      ),
    );
  });
}
