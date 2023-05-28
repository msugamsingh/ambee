import 'package:ambee/app/home/model/weather_data_model.dart';
import 'package:ambee/app/home/repo/home_repo.dart';
import 'package:ambee/data/network/network_error_messages.dart';
import 'package:ambee/data/response/repo_response.dart';
import 'package:ambee/utils/helper/my_logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final HomeRepository _repo = HomeRepository();

  Future<void> getWeather(double? lat, double? lon) async {
    if (state.isLoading) return;
    emit(
      state.copyWith(isLoading: true, error: null, lat: lat, lon: lon),
    );

    RepoResponse<WeatherData> response = await _repo.getWeather(
      lat: lat ?? state.lat,
      lon: lon ?? state.lon,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(state.lat, state.lon);

    if (response.error == null && response.data != null) {
      Log.i(response.data?.toJson());
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          currentWeather: response.data?.current?.weather?.first,
          weatherData: response.data,
          location: placemarks.first.locality ?? 'Unknown',
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

  void onHourlyItemTap(int index) {
    if (index == state.selectedHourIndex) {
      emit(
        state.copyWith(
          selectedHourIndex: -1,
          currentWeather: state.weatherData?.current?.weather?.first,
          selectedHourData: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedHourIndex: index,
          currentWeather: state.weatherData?.hourly?[index].weather?.first,
          selectedHourData: state.weatherData?.hourly?[index],
        ),
      );
    }
  }

  String getWindSpeed() {
    return '${(state.selectedHourIndex >= 0 ? state.selectedHourData?.windSpeed : state.weatherData?.current?.windSpeed) ?? ''}'
        ' m/s';
  }

  String? getTemp() {
    return state.selectedHourIndex >= 0
        ? state.selectedHourData?.temp?.toString()
        : state.weatherData?.current?.temp?.toString();
  }

  String getHumidity() {
    return '${(state.selectedHourIndex >= 0 ? state.selectedHourData?.humidity : state.weatherData?.current?.humidity) ?? ''}'
        '%';
  }

  String getRainPop() {
    return '${((state.selectedHourData?.pop) ?? 0) * 100}%';
  }

  String getUVI() {
    return (state.weatherData?.current?.uvi?.toString()) ?? '';
  }

  getLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(state.lat, state.lon);
    return placemarks.first.name ?? 'unknow';
  }
}
