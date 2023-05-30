import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/app/home/widget/hourly_weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Hourly Listview for the home page
class HourlyListFragment extends StatelessWidget {
  const HourlyListFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: state.weatherData?.hourly?.length ?? 0,
          itemBuilder: (con, index) {
            return GestureDetector(
              onTap: () {
                context.read<HomeCubit>().onHourlyItemTap(index);
              },
              child: Padding(
                padding: index == 0
                    ? const EdgeInsets.only(left: 8)
                    : index == state.weatherData!.hourly!.length
                        ? const EdgeInsets.only(right: 8)
                        : EdgeInsets.zero,
                child: HourlyWeather(
                  selected: state.selectedHourIndex == index,
                  hourly: state.weatherData?.hourly?[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
