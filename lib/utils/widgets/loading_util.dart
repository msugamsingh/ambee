import 'package:ambee/utils/values/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingUtil {
  static bool isOnDisplay = false;
  static BuildContext? loadingContext;

  static void showLoader(context) {
    isOnDisplay = true;
    loadingContext = context;
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6),
      // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Center(
            child: Transform.scale(
              scale: 1,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.sun),
              ),
            ),
          ),
        );
      },
    );
  }

  static void hideLoader() {
    if (isOnDisplay && loadingContext != null) {
      Navigator.pop(loadingContext!);
      isOnDisplay = false;
    }
  }
}
