part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? error;
  final Weather? currentWeather;
  final WeatherData? weatherData;
  final String location;
  final double lat;
  final double lon;
  final int selectedHourIndex;
  final Hourly? selectedHourData;
  final Daily? selectedDailyData;
  final int selectedDailyIndex;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.currentWeather,
    this.weatherData,
    this.location = 'Banglore',
    this.lat = 12.97,
    this.lon = 77.59,
    this.selectedHourIndex = -1,
    this.selectedDailyIndex = -1,
    this.selectedDailyData,
    this.selectedHourData,
  });

  HomeState copyWith({
    bool? isLoading,
    Weather? currentWeather,
    String? location,
    double? lat,
    double? lon,
    String? error,
    WeatherData? weatherData,
    int? selectedHourIndex,
    int? selectedDailyIndex,
    Hourly? selectedHourData,
    Daily? selectedDailyData,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      currentWeather: currentWeather ?? this.currentWeather,
      location: location ?? this.location,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      error: error ?? this.error,
      weatherData: weatherData ?? this.weatherData,
      selectedDailyIndex: selectedDailyIndex ?? this.selectedDailyIndex,
      selectedHourIndex: selectedHourIndex ?? this.selectedHourIndex,
      selectedDailyData: selectedDailyData ?? this.selectedDailyData,
      selectedHourData: selectedHourData ?? this.selectedHourData,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        currentWeather,
        location,
        lat,
        lon,
        error,
        weatherData,
        selectedDailyIndex,
        selectedHourIndex,
        selectedHourData,
        selectedDailyData,
      ];
}
