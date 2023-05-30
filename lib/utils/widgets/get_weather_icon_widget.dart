import 'package:ambee/utils/values/app_icons.dart';
import 'package:flutter/material.dart';

class GetWeatherIcon extends StatelessWidget {
  final String? name;
  final double width;
  final double height;
  final BoxFit? fit;

  const GetWeatherIcon(
      {Key? key,
      this.name,
      required this.width,
      required this.height,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (name != null)
        ? Image.asset(
            WeatherIcons.getWeatherIcon(name!),
            width: width,
            height: height,
            fit: fit ?? BoxFit.fitHeight,
          )
        : SizedBox(
            height: height,
            width: width,
          );
  }
}
