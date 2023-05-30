import 'package:ambee/utils/storage/storage.dart';
import 'package:flutter/material.dart';

class Styles {
  Styles._privateConstructor();

  static var theme = Storage.getTheme();

  static const TextStyle tsRegularBodyText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );
  static const TextStyle tsRegularBodyText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
  );

  static const TextStyle tsRegularExtraLarge72 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 72,
  );

  static const TextStyle tsRegularMidHeadline18 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
  );
  static const TextStyle tsRegularHeadline22 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22.0,
  );

  static const TextStyle tsRegularHeadline32 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32.0,
  );

  static const TextStyle tsRegularHeadline24 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24.0,
  );

  static const TextStyle tsRegularRightMidHeadline18 = TextStyle(
    fontFamily: 'right',
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
  );

  static const TextStyle tsRegularBodyText18 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
  );
  static const TextStyle tsRegularLight14 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14.0,
  );
  static const TextStyle tsLight12 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12.0,
  );
  static const TextStyle tsRegularLight12 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );
  static const TextStyle tsRegularLight10 = TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 10.0,
  );
  static const TextStyle tsRegularThin12 = TextStyle(
    fontWeight: FontWeight.w100,
    fontSize: 12.0,
  );
  static const TextStyle tsRegularThin10 = TextStyle(
    fontWeight: FontWeight.w100,
    fontSize: 10.0,
  );

  static const TextStyle tsRegularBold14 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
  );
  static const TextStyle tsRegularBold16 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );

  static const TextStyle tsAppBar = TextStyle(
    fontFamily: 'right',
    fontWeight: FontWeight.w500,
    fontSize: 24.0,
  );
}
