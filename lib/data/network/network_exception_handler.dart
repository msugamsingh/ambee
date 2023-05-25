import 'package:ambee/data/network/network_error_messages.dart';
import 'package:dio/dio.dart';

class APIException implements Exception {
  final String message;

  APIException({required this.message});
}

class NetworkExceptionHandler {
  static APIException handleError(Exception error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.sendTimeout:
          return APIException(message: ErrorMessages.noInternet);
        case DioErrorType.connectionTimeout:
          return APIException(message: ErrorMessages.connectionTimeout);
        case DioErrorType.badResponse:
          return APIException(
              message: ErrorResponse.fromJson(error.response?.data).message);
        default:
          return APIException(message: ErrorMessages.noInternet);
      }
    } else {
      return APIException(message: ErrorMessages.networkGeneral);
    }
  }
}


class ErrorResponse {
  late String message;

  ErrorResponse({required this.message});

  ErrorResponse.fromJson(json) {
    if (json is String) {
      message = json;
    } else {
      message = json['message'] ?? '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}