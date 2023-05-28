import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({Key? key}) : super(key: key);

  Widget _showPredictionList(HomeCubit cubit, HomeState state) {
    return state.loadingPredictions
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Expanded(
            child: ListView.separated(
              itemCount: state.locationPredictions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    cubit.onPredictionSelect(
                        state.locationPredictions[index].fullText);
                  },
                  leading: const Icon(AppIcons.location),
                  title: Text(state.locationPredictions[index].fullText),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.white38
                      : AppColors.bgColor.withOpacity(0.38),
                  indent: 20,
                  endIndent: 20,
                  thickness: 0.5,
                );
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        AppIcons.location,
                        size: 20,
                      ),
                      Text(
                        'Location',
                        style: Styles.tsRegularHeadline22,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      AppIcons.clear,
                      size: 28,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.white38
                          : AppColors.bgColor.withOpacity(0.38),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: kTextTabBarHeight,
                child: TextField(
                  controller: context.read<HomeCubit>().locationController,
                  decoration: InputDecoration(
                    label: const Text('Location'),
                    hintText: 'Delhi',
                    contentPadding: const EdgeInsets.all(
                      20,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.white38
                            : AppColors.bgColor.withOpacity(0.38),
                      ),
                      borderRadius: BorderRadius.circular(
                        14.0,
                      ),
                    ),
                  ),
                  autofocus: true,
                  onChanged: cubit.predict,
                ),
              ),
              const SizedBox(height: 8),
              _showPredictionList(cubit, state),
            ],
          );
        },
      ),
    );
  }
}
