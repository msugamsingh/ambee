import 'dart:io';
import 'package:ambee/data/constants.dart';
import 'package:ambee/data/env.dart';
import 'package:ambee/data/network/network_exception_handler.dart';
import 'package:dio/dio.dart';

class NetworkRequester {
  late Dio _dio;

  NetworkRequester._privateConstructor() {
    prepareRequest();
  }

  static final NetworkRequester shared = NetworkRequester._privateConstructor();

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout:  const Duration(seconds: 10),
      baseUrl: URLs.baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      queryParameters: {
        'appid': API_KEY,
      },
      headers: {
        'Accept': "*/*",
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      },
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.addAll([
      LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      )
    ]);
  }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
      );
      return response.data;
    } on SocketException catch (_) {
      return NetworkExceptionHandler.handleError(Exception('Network Error'));
    } on Exception catch (exception) {
      return NetworkExceptionHandler.handleError(exception);
    }
  }

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
      );
      return response.data;
    } on SocketException catch (_) {
      return NetworkExceptionHandler.handleError(Exception('Network Error'));
    } on Exception catch (error) {
      return NetworkExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(path, queryParameters: query, data: data);
      return response.data;
    } on Exception catch (error) {
      return NetworkExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response =
      await _dio.patch(path, queryParameters: query, data: data);
      return response.data;
    } on Exception catch (error) {
      return NetworkExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: query,
        data: data,
      );
      return response.data;
    } on Exception catch (error) {
      return NetworkExceptionHandler.handleError(error);
    }
  }
}