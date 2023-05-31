import 'package:ambee/app/user/bloc/user_cubit.dart';
import 'package:ambee/data/routes.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/data/theme/theme_cubit.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/widgets/double_block_stack_widget.dart';
import 'package:ambee/utils/widgets/get_weather_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Drawer which contains settings for app
class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  Widget addEditWidget(BuildContext context, UserCubit cubit, UserState state) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.addUser);
      },
      leading: const Icon(
        AppIcons.user,
        color: AppColors.white38,
      ),
      title: Text(
        state.user?.name ?? 'Add Name',
        style: Styles.tsRegularBodyText.copyWith(color: AppColors.white),
      ),
      subtitle: Text(
        state.user?.email ?? 'Tap to add name',
        style: Styles.tsLight12.copyWith(
          color: AppColors.white38,
        ),
      ),
    );
  }

  Widget toggleTheme(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const GetWeatherIcon(
          width: 34,
          height: 34,
          name: '01d',
        ),
        Switch(
          value: Theme.of(context).brightness == Brightness.dark,
          inactiveThumbImage: AssetImage(WeatherIcons.getWeatherIcon('01d')),
          activeThumbImage: AssetImage(WeatherIcons.getWeatherIcon('01n')),
          activeColor: AppColors.white24,
          inactiveThumbColor: AppColors.white24,
          inactiveTrackColor: AppColors.white24,
          onChanged: (_) {
            BlocProvider.of<ThemeCubit>(context).changeTheme();
          },
        ),
        const GetWeatherIcon(
          width: 34,
          height: 34,
          name: '01n',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          UserCubit cubit = context.read<UserCubit>();
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: DoubleStackWidget(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: kToolbarHeight * 2,
                    ),
                    addEditWidget(context, cubit, state),
                    const SizedBox(height: 24),
                    Text(
                      'Toggle Theme',
                      style: Styles.tsRegularBodyText.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    toggleTheme(context),
                    const Spacer(),
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Made With ❤️',
                      style: Styles.tsRegularBodyText2,
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
