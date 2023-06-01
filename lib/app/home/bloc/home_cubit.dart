import 'dart:async';

import 'package:ambee/app/home/model/weather_data_model.dart';
import 'package:ambee/app/home/repo/home_repo.dart';
import 'package:ambee/data/constants.dart';
import 'package:ambee/data/network/network_error_messages.dart';
import 'package:ambee/data/response/repo_response.dart';
import 'package:ambee/services/firebase_dynamic_link_services.dart';
import 'package:ambee/utils/helper/my_logger.dart';
import 'package:ambee/utils/helper/string_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:geocoding/geocoding.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    FirebaseDynamicLinkServices.onReceiveDynamicLink(_onReceiveLink);
    timer = Timer.periodic(const Duration(minutes: 10), (_) {
      if (!state.isLoading) {
        /// silently updating data in every 10 min
        getWeather(state.lat, state.lon, silent: true);
      }
    });
  }

  // Timer object for periodic weather data updates
  Timer? timer;

  // Repository for weather data
  final HomeRepository _repo = HomeRepository();

  // Google Places SDK instance for location prediction
  final FlutterGooglePlacesSdk _places = FlutterGooglePlacesSdk(GOOGLE_API_KEY);

  final locationController = TextEditingController();

  final PlaceTypeFilter _placeTypeFilter = PlaceTypeFilter.CITIES;

  // Timer for debouncing location prediction requests
  Timer? _debounce;

  // Method: Handles dynamic link data received by the app
  void _onReceiveLink(PendingDynamicLinkData pendingDynamicLinkData) {
    if (pendingDynamicLinkData != null) {
      final Uri deepLink = pendingDynamicLinkData.link;
      final double? lat =
          double.tryParse(deepLink.queryParameters['lat'] ?? '');
      final double? lon =
          double.tryParse(deepLink.queryParameters['lon'] ?? '');
      Log.wtf((lat, lon));
      if (lat != null && lon != null) {
        getWeather(lat, lon);
      }
      // else show some toast
    }
  }

  // Method: Retrieves weather data based on the provided latitude and longitude
  Future<void> getWeather(
    double? lat,
    double? lon, {
    bool force = false,
    bool updateLocation = true,
    bool silent = false, // fetch data without triggering the loading state
  }) async {
    if (state.isLoading && !force) return;

    // not setting isLoading to true if a method is silent
    emit(
      state.copyWith(
        isLoading: !silent,
        error: null,
        lat: lat,
        lon: lon,
      ),
    );

    RepoResponse<WeatherData> response = await _repo.getWeather(
      lat: lat ?? state.lat,
      lon: lon ?? state.lon,
    );

    if (response.error == null && response.data != null) {
      Log.i(response.data?.toJson());

      List<Placemark>? placemarks;

      // updating location from coordinates only if updateLocation is true;
      // not updating location label if its selected from prediction list
      try {
        if (updateLocation) {
          placemarks = await placemarkFromCoordinates(state.lat, state.lon);
        }
      } catch (e) {
        Log.e(e);
      }

      Log.wtf(placemarks);

      // emit the fetched data
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          currentWeather: response.data?.current?.weather?.first,
          weatherData: response.data,
          location:
              updateLocation ? (placemarks?.first.locality ?? 'Unknown') : null,
        ),
      );
    } else {
      if (!silent) {
        // not showing err if its a silent update
        emit(
          state.copyWith(
            isLoading: false,
            error: response.error?.message ?? ErrorMessages.somethingWentWrong,
          ),
        );
      }
    }
  }

  void setLatLon(lat, lon) => emit(state.copyWith(lat: lat, lon: lon));

  // Method: Disables loading predictions state in the state
  void offPredictLoading() => emit(state.copyWith(loadingPredictions: false));

  void cancelDebounce() => _debounce?.cancel();

  void onBottomSheetClose() {
    locationController.text = '';
    emit(state.copyWith(locationPredictions: const []));
  }

  // Method: Predicts locations based on the provided query string
  void predict(String s) async {
    // added a debouncer to handle the multi-calls on changing of query
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (s.isNullOrEmpty) {
        emit(
          state.copyWith(
              locationPredictions: const [], loadingPredictions: false),
        );
        return;
      }
      try {
        // finding cities based on the query
        final result = await _places.findAutocompletePredictions(
          s,
          placeTypeFilter: _placeTypeFilter,
          newSessionToken: false,
        );

        // updating the results
        emit(
          state.copyWith(
            locationPredictions: result.predictions,
            loadingPredictions: false,
          ),
        );
      } catch (e) {
        Log.e(e);
      } finally {
        emit(state.copyWith(loadingPredictions: false));
      }
    });

    // loading state to show the CPI
    emit(state.copyWith(loadingPredictions: true));
  }

  // Method: Handles the selection of a location prediction
  Future<void> onPredictionSelect(String title,) async {
    if (title.isNullOrEmpty) return;
    // location from prediction
    String locality = title.split(',').first;
    emit(state.copyWith(isLoading: true, error: null));

    // locations based on the selected address/prediction
    List<Location>? locations;
    Location? location;

    // trying to get the location for the co-ordinates
    try {
      locations = await locationFromAddress(title);
    } catch (e) {
      emit(
        state.copyWith(
            error: 'Couldn\'t find the selected location', isLoading: false),
      );
      return;
    }

    if (locations != null && locations.isNotEmpty) {
      location = locations.first;
    }

    // show error if failed
    if (location == null) {
      emit(
        state.copyWith(
            error: 'Couldn\'t find the selected location', isLoading: false),
      );
      return;
    }

    // update the locality with the selected name
    emit(state.copyWith(location: locality, error: null));
    await getWeather(
      location.latitude,
      location.longitude,
      force: true,
      updateLocation: false,
    );

    // setting the controller to empty once done fetching
    locationController.text = '';
  }

  // method: show the weather data from the selected hourly widget
  void onHourlyItemTap(int index) {
    // toggle from hourly to current, vice-versa
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

  // Method: Retrieves the wind speed based on the selected hourly item or current weather data
  String getWindSpeed() {
    return '${(state.selectedHourIndex >= 0 ? state.selectedHourData?.windSpeed : state.weatherData?.current?.windSpeed) ?? ''}'
        ' m/s';
  }

  // Method: Retrieves the temperature based on the selected hourly item or current weather data
  String? getTemp() {
    return state.selectedHourIndex >= 0
        ? state.selectedHourData?.temp?.toString()
        : state.weatherData?.current?.temp?.toString();
  }

  // Method: Retrieves the humidity based on the selected hourly item or current weather data
  String getHumidity() {
    return '${(state.selectedHourIndex >= 0 ? state.selectedHourData?.humidity : state.weatherData?.current?.humidity) ?? ''}'
        '%';
  }

  // Method: Retrieves the rain probability based on the selected hourly item or current weather data
  String getRainPop() {
    return '${(((state.selectedHourData?.pop) ?? 0) * 100).toInt()}%';
  }

  // Method: Retrieves the UV index based on the current weather data
  String getUVI() {
    return (state.weatherData?.current?.uvi?.toString()) ?? '';
  }

  void onLocationSearchPredict() async {
    var query = locationController.text.trim();
    if (query.isNullOrEmpty) return;

    emit(
      state.copyWith(isLoading: true, error: null),
    );

    List<Location>? locations;
    Location? location;

    // trying to get the location of the searched query
    try {
      locations = await locationFromAddress(query);
    } catch (e) {
      emit(
        state.copyWith(
            error: 'Couldn\'t find the desired location', isLoading: false),
      );
      return;
    }

    if (locations != null && locations.isNotEmpty) {
      location = locations.first;
    }

    // if failed to get the location
    if (location == null) {
      emit(
        state.copyWith(
            error: 'Couldn\'t find the desired location', isLoading: false),
      );
      return;
    }

    // update data if found the co-ordinates of the selected query
    await getWeather(
      location.latitude,
      location.longitude,
      force: true,
      updateLocation: true,
    );

    // setting the controller to empty once done fetching
    locationController.text = '';
  }

  @override
  Future<void> close() {
    timer?.cancel();
    _debounce?.cancel();
    return super.close();
  }
}
