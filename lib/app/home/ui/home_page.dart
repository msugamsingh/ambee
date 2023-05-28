import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/app/home/ui/home_page_hourly_list.dart';
import 'package:ambee/app/home/ui/show_location_bottomsheet.dart';
import 'package:ambee/app/home/widget/location_field_bottomsheet.dart';
import 'package:ambee/data/routes.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/data/theme/theme_cubit.dart';
import 'package:ambee/utils/helper/date_formatter.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/widgets/degree_text.dart';
import 'package:ambee/utils/widgets/loading_util.dart';
import 'package:ambee/utils/widgets/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  AppBar appBar(BuildContext context, HomeState state, HomeCubit cubit) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(AppIcons.boltCircular),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.splash);
        },
      ),
      title: GestureDetector(
        onTap: () {
          cubit.offPredictLoading();
          kAppShowModalBottomSheet(context, const LocationBottomSheet());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              AppIcons.location,
              size: 20,
            ),
            Text(state.location),
          ],
        ),
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
        height: width / 1.5,
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

  Widget detailsRow(HomeCubit cubit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        detailRowItem(AppIcons.wind, cubit.getWindSpeed(), 'Wind'),
        detailRowItem(AppIcons.humidity, cubit.getHumidity(), 'Humidity'),
        (cubit.state.selectedHourIndex >= 0)
            ? detailRowItem(AppIcons.rain, cubit.getRainPop(), 'Chances')
            : detailRowItem(AppIcons.uv, cubit.getUVI(), 'UV'),
      ],
    );
  }

  Widget weatherContent(double width, HomeState state, HomeCubit cubit) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: kToolbarHeight * 2,
              ),
              getWeatherIcon(state: state, width: width),
              DegreeText(
                text: cubit.getTemp(),
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
                formattedDate(DateTime.now(), DateFormatter.DAY_DATE_MONTH),
                style: Styles.tsRegularBodyText.copyWith(
                  color: AppColors.white38,
                ),
              ),
              const Spacer(),
              const Divider(
                color: AppColors.white38,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              detailsRow(cubit),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (c, state) {
        var cubit = c.read<HomeCubit>();
        if (state.isLoading && !LoadingUtil.isOnDisplay) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            LoadingUtil.showLoader(context);
          });
        } else if (!state.isLoading) {
          LoadingUtil.hideLoader();
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: appBar(c, state, cubit),
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: weatherContent(width, state, cubit),
              ),
              Expanded(
                child: Container(
                  color: AppColors.transparent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today',
                              style: Styles.tsRegularHeadline22,
                            ),
                            TextIconButton(
                              label: '7 days',
                              icon: AppIcons.chevronForward,
                              padding: const EdgeInsets.only(left: 8),
                              onTap: () {},
                              iconSize: 14,
                              style: Styles.tsRegularBodyText.copyWith(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.white38
                                    : AppColors.bgColor.withOpacity(0.38),
                              ),
                              iconColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.white38
                                  : AppColors.bgColor.withOpacity(0.38),
                            )
                          ],
                        ),
                      ),
                      const Expanded(child: HourlyListFragment()),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
