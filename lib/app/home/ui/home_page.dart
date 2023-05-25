import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/values/theme/text_styles.dart';
import 'package:ambee/utils/widgets/degree_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(AppIcons.boltCircular),
        onPressed: () {},
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
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
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
                      Image.asset(
                        WeatherIcons.icRainWithWind,
                        width: width / 1.5,
                      ),
                      const SizedBox(
                        height: 10 * 2,
                      ),
                      const DegreeText(
                          text: '21', style: Styles.tsRegularExtraLarge148,),
                      const Text('Thunderstorm', style: Styles.tsRegularHeadline24,)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.bgColor,
            ),
          )
        ],
      ),
    );
  }
}
