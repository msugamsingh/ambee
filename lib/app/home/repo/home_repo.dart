import 'package:ambee/app/home/model/weather_data_model.dart';
import 'package:ambee/data/env.dart';
import 'package:ambee/data/network/network_exception_handler.dart';
import 'package:ambee/data/network/network_requester.dart';
import 'package:ambee/data/response/repo_response.dart';

/// Repository class responsible for fetching weather data.
class HomeRepository {
  /// Fetches weather data based on the provided latitude and longitude.
  ///
  /// Returns a [RepoResponse] object wrapping the fetched weather data.
  /// If the request is successful, [RepoResponse.data] will contain the weather data.
  /// If an error occurs during the request, [RepoResponse.error] will contain the error details.
  Future<RepoResponse<WeatherData>> getWeather({
    required double lat,
    required double lon,
  }) async {
    var response = await NetworkRequester.shared.get(
        path: URLs.getWeather,
        query: {
          'lat': lat,
          'lon': lon,
          'exclude': 'minutely',
          'units': 'metric'
        });
    return response is APIException
        ? RepoResponse(error: response, data: null)
        : RepoResponse(data: WeatherData.fromJson(response));
  }
}
