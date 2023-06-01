import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// call to show any bottomsheet, contains predefined style and properties
// for bottomsheet
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
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
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
          // cancelling debounce on home cubit when closes the bottomsheet
          BlocProvider.of<HomeCubit>(context).cancelDebounce();
          BlocProvider.of<HomeCubit>(context).onBottomSheetClose();
        }
      }
    },
  );
}
