import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/app/home/widget/weather_detail_item_widget.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/utils/helper/date_formatter.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/widgets/degree_text.dart';
import 'package:ambee/utils/widgets/double_block_stack_widget.dart';
import 'package:ambee/utils/widgets/get_weather_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Page to show the weather data for 8 upcoming days
class DailyData extends StatelessWidget {
  const DailyData({Key? key}) : super(key: key);

  AppBar appBar(BuildContext context, HomeState state, HomeCubit cubit) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          AppIcons.backButton,
          size: 28,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            AppIcons.calendar,
            size: 20,
          ),
          Text("7 days"),
        ],
      ),
    );
  }

  // Other weather details for tomorrow
  Widget detailsRow(HomeCubit cubit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WeatherDetailItem(
          icon: AppIcons.wind,
          value:
              "${cubit.state.weatherData?.daily?.first.windSpeed?.toString() ?? ''}"
              " m/s",
          label: 'Wind',
        ),
        WeatherDetailItem(
          icon: AppIcons.humidity,
          value:
              "${cubit.state.weatherData?.daily?.first.humidity?.toString() ?? ''}"
              "%",
          label: 'Humidity',
        ),
        WeatherDetailItem(
          icon: AppIcons.rain,
          value: ("${((cubit.state.weatherData?.daily?.first.pop ?? 0) * 100).toInt()}%"),
          label: 'Chances',
        ),
      ],
    );
  }

  // Complete weather details for tomorrow
  Widget weatherContent(
      double width, HomeState state, HomeCubit cubit, BuildContext context) {
    return DoubleStackWidget(
      children: [
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: GetWeatherIcon(
                width: width / 4,
                height: width / 4,
                name: state.weatherData?.daily?[2].weather?.first.icon,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      'Tomorrow',
                      style: Styles.tsRegularHeadline22
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DegreeText(
                        text: "${state.weatherData?.daily?[2].temp?.max ?? 0}",
                        style: Styles.tsRegularHeadline32,
                        color: AppColors.white,
                        degreeSize: 8,
                      ),
                      Text(
                        '/',
                        style: Styles.tsRegularBold16.copyWith(
                          color: AppColors.white38,
                        ),
                      ),
                      DegreeText(
                        text: "${state.weatherData?.daily?[2].temp?.min ?? 0}",
                        degreeSize: 6,
                        color: AppColors.white38,
                        style: Styles.tsRegularBold16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    state.weatherData?.daily?[2].weather?.first.main ??
                        'Unknown',
                    style: Styles.tsRegularBodyText.copyWith(
                      color: AppColors.white38,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const Spacer(),
        const Divider(
          color: AppColors.white38,
          indent: 20,
          endIndent: 20,
          thickness: 0.5,
        ),
        detailsRow(cubit),
      ],
    );
  }

  // List for 8 days weather details
  Widget dailyList(BuildContext context, HomeCubit cubit, double width) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          cubit.state.weatherData?.daily?.length ?? 0,
          (index) => index == 0
              ? const SizedBox.shrink()
              : ListTile(
                  title: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetWeatherIcon(
                          width: (width * 0.3) / 4,
                          height: (width * 0.3) / 4,
                          name: cubit.state.weatherData?.daily?[index].weather
                              ?.first.icon,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${cubit.state.weatherData?.daily?[index].weather?.first.main}",
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.white38
                                    : AppColors.bgColor38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  leading: Text(
                    formattedDate(
                      DateTime.fromMillisecondsSinceEpoch(
                          (cubit.state.weatherData?.daily?[index].dt ?? 0) *
                              1000),
                      DateFormatter.SHORT_DAY,
                    ),
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.white38
                          : AppColors.bgColor38,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "+",
                        style: Styles.tsRegularBold14,
                      ),
                      DegreeText(
                        text:
                            "${cubit.state.weatherData?.daily?[index].temp?.max}",
                        style: Styles.tsRegularBold14,
                        degreeSize: 5,
                      ),
                      Text(
                        "+",
                        style: Styles.tsRegularBold14.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white38
                              : AppColors.bgColor38,
                        ),
                      ),
                      DegreeText(
                        text:
                            "${cubit.state.weatherData?.daily?[index].temp?.min ?? 0}",
                        style: Styles.tsRegularBold14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.white38
                            : AppColors.bgColor38,
                        degreeSize: 5,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: appBar(context, state, cubit),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: weatherContent(width, state, cubit, context),
              ),
              Expanded(
                flex: 4,
                child: dailyList(context, cubit, width),
              )
            ],
          ),
        );
      },
    );
  }
}
