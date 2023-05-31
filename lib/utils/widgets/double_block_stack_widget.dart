import 'package:ambee/utils/values/app_colors.dart';
import 'package:flutter/material.dart';

class DoubleStackWidget extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  const DoubleStackWidget(
      {Key? key,
      required this.children,
      this.crossAxisAlignment,
      this.mainAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width / 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(width / 5),
                  bottomRight: Radius.circular(width / 5),
                ),
                color: AppColors.darkPrimary,
              ),
              height: 100,
            ),
          ),
        ),
        Container(
          width: width,
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.mainColorPrimary.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 20,
              ),
            ],
            border: Border.all(color: AppColors.mainColorSecondary, width: 0.5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width / 5),
              bottomRight: Radius.circular(width / 5),
            ),
            gradient: const LinearGradient(
              colors: [
                AppColors.mainColorSecondary,
                AppColors.mainColorPrimary,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
              mainAxisAlignment: mainAxisAlignment ??  MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
