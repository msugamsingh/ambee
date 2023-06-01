import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/app/home/ui/end_drawer.dart';
import 'package:ambee/app/home/ui/home_page_hourly_list.dart';
import 'package:ambee/app/home/ui/show_location_bottomsheet.dart';
import 'package:ambee/app/home/widget/location_field_bottomsheet.dart';
import 'package:ambee/app/home/widget/weather_detail_item_widget.dart';
import 'package:ambee/data/routes.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/utils/helper/date_formatter.dart';
import 'package:ambee/utils/helper/string_extensions.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/widgets/degree_text.dart';
import 'package:ambee/utils/widgets/double_block_stack_widget.dart';
import 'package:ambee/utils/widgets/err_snackbar.dart';
import 'package:ambee/utils/widgets/get_weather_icon_widget.dart';
import 'package:ambee/utils/widgets/loading_util.dart';
import 'package:ambee/utils/widgets/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  AppBar appBar(BuildContext context, HomeState state, HomeCubit cubit) {
    return AppBar(
      centerTitle: true,
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
            Text(
              state.location,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(AppIcons.threeDotsMenu),
          onPressed: () {
            scaffoldKey.currentState!.openEndDrawer();
          },
        ),
      ],
    );
  }

  // method to build details of selected weather
  Widget detailsRow(HomeCubit cubit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WeatherDetailItem(
            icon: AppIcons.wind, value: cubit.getWindSpeed(), label: 'Wind'),
        WeatherDetailItem(
            icon: AppIcons.humidity,
            value: cubit.getHumidity(),
            label: 'Humidity'),
        (cubit.state.selectedHourIndex >= 0)
            ? WeatherDetailItem(
                icon: AppIcons.rain,
                value: cubit.getRainPop(),
                label: 'Chances')
            : WeatherDetailItem(
                icon: AppIcons.uv, value: cubit.getUVI(), label: 'UV')
      ],
    );
  }

  // Selected/Current weather details widget
  Widget weatherContent(double width, HomeState state, HomeCubit cubit) {
    return DoubleStackWidget(
      children: [
        Expanded(
          child: GetWeatherIcon(
            name: state.currentWeather?.icon,
          ),
        ),
        DegreeText(
          text: cubit.getTemp(),
          style: Styles.tsRegularExtraLarge72.copyWith(
            color: AppColors.white,
          ),
          degreeSize: 16,
        ),
        Text(
          state.currentWeather?.main?.toString() ?? 'Unknown',
          style: Styles.tsRegularMidHeadline18.copyWith(
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
      ],
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        if (state.isLoading && !LoadingUtil.isOnDisplay) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            LoadingUtil.showLoader(context);
          });
        } else if (!state.isLoading) {
          LoadingUtil.hideLoader();
        }

        if (!state.error.isNullOrEmpty) {
          onError(context: context, message: state.error);
        }
        return Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          endDrawer: const EndDrawer(),
          appBar: appBar(context, state, cubit),
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
                            ((state.weatherData?.daily?.length ?? 0) >= 2)
                                ? TextIconButton(
                                    label: '7 days',
                                    icon: AppIcons.chevronForward,
                                    padding: const EdgeInsets.only(left: 8),
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.daily);
                                    },
                                    iconSize: 14,
                                    style: Styles.tsRegularBodyText.copyWith(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppColors.white38
                                          : AppColors.bgColor38,
                                    ),
                                    iconColor: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.white38
                                        : AppColors.bgColor38,
                                  )
                                : const SizedBox(width: 8),
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
