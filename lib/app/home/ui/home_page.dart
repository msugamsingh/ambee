import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/data/routes.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/data/theme/theme_cubit.dart';
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

  Widget getWeatherIcon({required HomeCubit cubit, required double width}) {
    if (cubit.state.currentWeather != null &&
        cubit.state.currentWeather!.icon != null) {
      return Image.asset(
        WeatherIcons.getWeatherIcon(cubit.state.currentWeather!.icon!),
        width: width / 1.5,
      );
    } else {
      return SizedBox(height: width / 1.5);
    }
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
                      margin: const EdgeInsets.only(bottom: 20.0),
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
                          getWeatherIcon(cubit: HomeCubit(), width: width),
                          const SizedBox(
                            height: 10 * 2,
                          ),
                          DegreeText(
                            text: state.weatherData?.current?.temp?.toString(),
                            style: Styles.tsRegularExtraLarge148.copyWith(
                              color: AppColors.white,
                            ),
                            degreeSize: 16,
                          ),
                          Text(
                            'Thunderstorm',
                            style: Styles.tsRegularHeadline24.copyWith(
                              color: AppColors.white,
                            ),
                          )
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
