import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future kAppShowModalBottomSheet(
  BuildContext context,
  Widget content, {
  EdgeInsets? padding,
  bool isDismissible = true,
  double? height,
  VoidCallback? whenComplete,
  bool disableWhenComplete = false,
}) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(64),
        topRight: Radius.circular(64),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: false,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          height: height ?? MediaQuery.of(context).size.height / 2,
          child: content,
        ),
      );
    },
    context: context,
  ).whenComplete(
    () {
      if (!disableWhenComplete) {
        if (whenComplete != null) {
          whenComplete();
        } else {
          BlocProvider.of<HomeCubit>(context).cancelDebounce();
        }
      }
    },
  );
}
