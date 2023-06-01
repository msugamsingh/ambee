import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:flutter/material.dart';

class DegreeText extends StatelessWidget {
  final String? text;
  final TextStyle style;
  final double? degreeSize;
  final Color? color;

  const DegreeText({
    Key? key,
    required this.text,
    this.style = Styles.tsRegularHeadline24,
    this.degreeSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: style.fontSize! * 1.2,
          constraints: const BoxConstraints(minWidth: 1),
          child: FittedBox(
            child: Container(
              constraints: const BoxConstraints(minWidth: 1),
              child: Text(
                text?.substring(0, 2) ?? '',
                textAlign: TextAlign.center,
                style: color != null ? style.copyWith(color: color) : style,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: style.fontSize! * 0.2),
          child: Icon(
            AppIcons.degree,
            color: color ?? style.color,
            size: degreeSize ?? (style.fontSize! * 0.2),
          ),
        ),
      ],
    );
  }
}
