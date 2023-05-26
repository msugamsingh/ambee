part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? error;
  final Weather? currentWeather;
  final WeatherData? weatherData;
  final String location;
  final double lat;
  final double lon;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.currentWeather,
    this.weatherData,
    this.location = 'Banglore',
    this.lat = 12.97,
    this.lon = 77.59,
  });

  HomeState copyWith({
    bool? isLoading,
    Weather? currentWeather,
    String? location,
    double? lat,
    double? lon,
    String? error,
    WeatherData? weatherData,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      currentWeather: currentWeather ?? this.currentWeather,
      location: location ?? this.location,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      error: error ?? this.error,
      weatherData: weatherData ?? this.weatherData,
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
      ];
}
