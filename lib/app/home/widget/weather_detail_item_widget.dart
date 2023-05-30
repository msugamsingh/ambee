import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:flutter/material.dart';

// Widget to show a specific weather detail with icon
class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetailItem(
      {Key? key, required this.icon, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.white,
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Styles.tsRegularLight12.copyWith(color: AppColors.white),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Styles.tsRegularLight12.copyWith(color: AppColors.white38),
          )
        ],
      ),
    );
  }
}
