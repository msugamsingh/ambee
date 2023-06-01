import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIcons {
  static const IconData home = Icons.home_outlined;
  static const IconData bookmark = Icons.bookmark_border;
  static const IconData blurCircular = Icons.blur_circular_outlined;
  static const IconData boltCircular = CupertinoIcons.bolt_circle;
  static const IconData location = Icons.location_pin;
  static const IconData threeDotsMenu = CupertinoIcons.ellipsis_vertical;
  static const IconData degree = CupertinoIcons.circle;
  static const IconData wind = CupertinoIcons.wind_snow;
  static const IconData humidity = CupertinoIcons.drop;
  static const IconData rain = CupertinoIcons.cloud_drizzle;
  static const IconData uv = CupertinoIcons.sun_max;
  static const IconData chevronForward = CupertinoIcons.chevron_forward;
  static const IconData clear = CupertinoIcons.clear_circled;
  static const IconData backButton = CupertinoIcons.chevron_left_circle;
  static const IconData calendar = CupertinoIcons.calendar;
  static const IconData user = CupertinoIcons.profile_circled;
}


// todo: Future Improvements - Bring down the icon sizes or use the openWeatherApi ones
class WeatherIcons {
  static const _path = 'assets/icons/weather/';

  static String getWeatherIcon(String name) {
    return '$_path$name.png';
  }
}
