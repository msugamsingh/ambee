import 'package:ambee/app/home/model/weather_data_model.dart';
import 'package:ambee/app/home/repo/home_repo.dart';
import 'package:ambee/data/network/network_error_messages.dart';
import 'package:ambee/data/response/repo_response.dart';
import 'package:ambee/utils/helper/my_logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    getWeather();
  }

  final HomeRepository _repo = HomeRepository();

  Future<void> getWeather() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, error: null));

    RepoResponse<WeatherData> response =
        await _repo.getWeather(lat: state.lat, lon: state.lon);
    if (response.error == null && response.data != null) {
      Log.i(response.data);
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          currentWeather: response.data?.current?.weather?.first,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          error: response.error?.message ?? ErrorMessages.somethingWentWrong,
        ),
      );
    }
  }

  void setLatLon(lat, lon) => emit(state.copyWith(lat: lat, lon: lon));
}
