import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/data/routes.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/data/theme/theme_cubit.dart';
import 'package:ambee/utils/helper/date_formatter.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/widgets/degree_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(AppIcons.boltCircular),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.splash);
        },
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            AppIcons.location,
            size: 20,
          ),
          Text('Banglore'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(AppIcons.threeDotsMenu),
          onPressed: () {
            context.read<ThemeCubit>().changeTheme();
          },
        ),
      ],
    );
  }

  Widget getWeatherIcon({required HomeState state, required double width}) {
    if (state.currentWeather != null && state.currentWeather!.icon != null) {
      return Image.asset(
        WeatherIcons.getWeatherIcon(state.currentWeather!.icon!),
        width: width / 1.5,
      );
    } else {
      return SizedBox(height: width / 1.5);
    }
  }

  Widget detailRowItem(IconData icon, String value, String label) {
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
            style: Styles.tsRegularLight12.copyWith(
                color: AppColors
                    .white), // todo: should be tsLight12, create tsRegular12 with w400
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

  Widget detailsRow(HomeState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        detailRowItem(AppIcons.wind,
            '${(state.weatherData?.current?.windSpeed) ?? ''}m/s', 'Wind'),
        detailRowItem(AppIcons.humidity,
            '${(state.weatherData?.current?.humidity) ?? ''}%', 'Humidity'),
        detailRowItem(
            AppIcons.rain,
            '${((state.weatherData?.current?.pop) ?? 0) * 100}%',
            'Chances of rain'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (c, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: appBar(context),
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: kToolbarHeight * 2,
                          ),
                          getWeatherIcon(state: state, width: width),
                          const SizedBox(
                            height: 10 * 2,
                          ),
                          DegreeText(
                            text: state.weatherData?.current?.temp?.toString(),
                            style: Styles.tsRegularExtraLarge100.copyWith(
                              color: AppColors.white,
                            ),
                            degreeSize: 16,
                          ),
                          Text(
                            state.currentWeather?.main?.toString() ?? 'Unknown',
                            style: Styles.tsRegularHeadline22.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            formattedDate(
                                DateTime.now(), DateFormatter.DAY_DATE_MONTH),
                            style: Styles.tsRegularBodyText.copyWith(
                              color: AppColors.white38,
                            ),
                          ),
                          const Divider(
                            color: AppColors.white38,
                            indent: 20,
                            endIndent: 20,
                            thickness: 0.5,
                          ),
                          detailsRow(state),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.transparent,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
