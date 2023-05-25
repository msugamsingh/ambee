import 'package:ambee/data/network/network_exception_handler.dart';
import 'package:ambee/data/network/network_requester.dart';
import 'package:ambee/data/response/repo_response.dart';

class HomeRepository {
  Future<RepoResponse> getAllPosts({required int offset}) async {
    var response = await NetworkRequester.shared.get(path: 'URLs.sampleVideos', query: {
      'limit': 20,
      'offset': offset
    });
    return response is APIException
        ? RepoResponse(error: response, data: null)
        : RepoResponse(data: null);
  }
}