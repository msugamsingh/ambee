import 'package:ambee/app/home/model/weather_data_model.dart';
import 'package:ambee/data/env.dart';
import 'package:ambee/data/network/network_exception_handler.dart';
import 'package:ambee/data/network/network_requester.dart';
import 'package:ambee/data/response/repo_response.dart';

class HomeRepository {
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
