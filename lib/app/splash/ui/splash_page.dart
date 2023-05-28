import 'dart:ui';

import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/app/splash/bloc/splash_cubit.dart';
import 'package:ambee/data/network/network_error_messages.dart';
import 'package:ambee/data/theme/theme_cubit.dart';
import 'package:ambee/utils/helper/string_extensions.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/widgets/degree_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  Widget positionedImage({
    required String image,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      // because it is beyond width
      left: left,
      bottom: bottom,
      right: right,
      top: top,
      child: Image.asset(
        image,
        width: 300,
        height: 300,
      ),
    );
  }

  Widget loadingCard(BuildContext context, SplashState state) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: GestureDetector(
              onTap: context.read<ThemeCubit>().changeTheme,
              child: Container(
                padding: const EdgeInsets.all(18),
                height: MediaQuery.sizeOf(context).width / 1.5,
                width: MediaQuery.sizeOf(context).width / 1.5,
                color: Colors.white12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    state.error.isNullOrEmpty
                        ? LoadingAnimationWidget.inkDrop(
                            color: AppColors.sun,
                            size: 100,
                          )
                        : LoadingAnimationWidget.newtonCradle(
                            color: AppColors.sun,
                            size: 100,
                          ),
                    const Spacer(),
                    const DegreeText(
                      text: 'ae',
                      degreeSize: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onError({
    required BuildContext context,
    String? message,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.bgColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          duration: const Duration(minutes: 5),
          content: Text(
            message ?? ErrorMessages.networkGeneral,
          ),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () {
              context.read<SplashCubit>().refreshFetchData(context);
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashCubit(context);
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.mainColorSecondary,
                AppColors.mainColor,
                AppColors.mainColorPrimary,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, splashState) {
              if (!splashState.error.isNullOrEmpty) {
                onError(context: context, message: splashState.error);
              }
              return BlocListener<HomeCubit, HomeState>(
                listenWhen: (_, __) => splashState.listen,
                listener: context.read<SplashCubit>().navigateToHome,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        positionedImage(
                          image: WeatherIcons.getWeatherIcon('02d'),
                          left: -constraints.maxWidth * .2,
                          right: -constraints.maxWidth * .1,
                          top: constraints.maxHeight - 200,
                        ),
                        positionedImage(
                          image: WeatherIcons.getWeatherIcon('shower_rain'),
                          left: constraints.maxWidth * .2,
                          right: constraints.maxWidth * .1,
                          bottom: constraints.maxHeight - 200,
                        ),
                        positionedImage(
                          image: WeatherIcons.getWeatherIcon('01d'),
                          left: constraints.maxWidth - 200,
                          bottom: constraints.maxHeight * .5,
                        ),
                        positionedImage(
                          image: WeatherIcons.getWeatherIcon('01n'),
                          right: constraints.maxWidth - 200,
                          top: constraints.maxHeight * .5,
                        ),
                        loadingCard(context, splashState),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
