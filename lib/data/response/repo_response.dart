import 'package:ambee/data/network/network_exception_handler.dart';

/// A generic response class used by repositories to encapsulate the result of an API request.
/// It can contain either the data of type [T] or an [APIException] error.
class RepoResponse<T> {
  /// The API exception representing the error, if any.
  final APIException? error;

  /// The data of type [T].
  final T? data;

  /// Returns `true` if the response contains data and no error.
  bool get hasData => data != null && error == null;

  /// Returns `true` if the response contains an error.
  bool get hasError => error != null;

  /// Constructs a [RepoResponse] object with the given [error] and [data].
  RepoResponse({this.error, this.data});
}