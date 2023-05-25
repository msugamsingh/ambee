import 'package:ambee/utils/values/app_icons.dart';
import 'package:ambee/utils/values/theme/text_styles.dart';
import 'package:flutter/material.dart';

class DegreeText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double? degreeSize;

  const DegreeText({
    Key? key,
    required this.text,
    this.style = Styles.tsRegularHeadline24,
    this.degreeSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: style.fontSize!, child: Text(text, style: style)),
        Padding(
          padding: EdgeInsets.only(top: style.fontSize! * 0.2),
          child: Icon(
            AppIcons.degree,
            size: degreeSize ?? (style.fontSize! * 0.2),
          ),
        ),
      ],
    );
  }
}
