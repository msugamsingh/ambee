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
  final List<AutocompletePrediction> locationPredictions;
  final bool loadingPredictions;

  /// Represents the state of the home screen in the application.
  ///
  /// The [isLoading] flag indicates whether the screen is currently loading data.
  /// The [error] field holds an optional error message if an error occurred during data retrieval.
  /// The [currentWeather] field represents the current weather.
  /// The [weatherData] field stores the overall weather data.
  /// The [location] field holds the location name.
  /// The [lat] and [lon] fields store the latitude and longitude coordinates.
  /// The [selectedHourIndex] represents the index of the selected hourly weather data.
  /// The [selectedHourData] holds the selected hourly weather data.
  /// The [locationPredictions] field stores a list of location predictions for autocomplete functionality.
  /// The [loadingPredictions] flag indicates whether location predictions are currently being loaded.

  const HomeState({
    this.isLoading = false,
    this.error,
    this.currentWeather,
    this.weatherData,
    this.location = 'Banglore',
    this.lat = 12.97,
    this.lon = 77.59,
    this.selectedHourIndex = -1,
    this.selectedHourData,
    this.locationPredictions = const [],
    this.loadingPredictions = false,
  });


  /// Returns a new [HomeState] object with the updated fields.
  HomeState copyWith({
    bool? isLoading,
    Weather? currentWeather,
    String? location,
    double? lat,
    double? lon,
    String? error,
    WeatherData? weatherData,
    int? selectedHourIndex,
    Hourly? selectedHourData,
    List<AutocompletePrediction>? locationPredictions,
    bool? loadingPredictions,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      currentWeather: currentWeather ?? this.currentWeather,
      location: location ?? this.location,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      error: error,
      weatherData: weatherData ?? this.weatherData,
      selectedHourIndex: selectedHourIndex ?? this.selectedHourIndex,
      selectedHourData: selectedHourData ?? this.selectedHourData,
      locationPredictions: locationPredictions ?? this.locationPredictions,
      loadingPredictions: loadingPredictions ?? this.loadingPredictions,
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
        selectedHourIndex,
        selectedHourData,
        locationPredictions,
        loadingPredictions,
      ];
}
