import 'package:ambee/app/home/model/weather_data_model.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/utils/helper/date_formatter.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/widgets/degree_text.dart';
import 'package:flutter/material.dart';

// Animated Widget for Hourly bottom list
class HourlyWeather extends StatelessWidget {
  final bool selected;
  final Hourly? hourly;

  const HourlyWeather({
    Key? key,
    this.selected = false,
    required this.hourly,
  }) : super(key: key);

  // gets icon from assets according to name
  Widget getIcon(context) {
    if (hourly?.weather?.first != null && hourly?.weather?.first.icon != null) {
      return Image.asset(
        WeatherIcons.getWeatherIcon(hourly!.weather!.first.icon!),
        width: MediaQuery.of(context).size.width / 6.5,
      );
    } else {
      return SizedBox(height: MediaQuery.of(context).size.width / 6.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// building hourly widget for today's hours only
    return hourly == null ||
            (hourly?.dt != null &&
                DateTime.now().day !=
                    DateTime.fromMillisecondsSinceEpoch(hourly!.dt! * 1000).day)
        ? const SizedBox.shrink()
        : AnimatedContainer(
            height: selected ? 120 : 100,
            width: selected ? 110 : 100,
            margin: selected
                ? const EdgeInsets.symmetric(horizontal: 8, vertical: 0)
                : const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: selected ? null : AppColors.transparent,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.white38
                    : AppColors.bgColor38,
              ),
              gradient: selected
                  ? const LinearGradient(
                      colors: [
                        AppColors.mainColorSecondary,
                        AppColors.mainColorPrimary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            duration: const Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DegreeText(
                  text: hourly?.temp?.toString(),
                  style: Styles.tsRegularMidHeadline18,
                  // color: Theme.of(context).brightness == Brightness.dark
                  //     ? AppColors.white
                  //     : AppColors.bgColor,
                ),
                getIcon(context),
                hourly?.dt != null
                    ? Text(
                        formattedDate(
                          DateTime.fromMillisecondsSinceEpoch(
                              hourly!.dt! * 1000),
                          DateFormatter.HOUR24_MINUTE,
                        ),
                        textAlign: TextAlign.center,
                        style: Styles.tsRegularBodyText.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white38
                              : AppColors.bgColor38,
                        ),
                      )
                    : const SizedBox(
                        height: 14,
                      ),
              ],
            ),
          );
  }
}
