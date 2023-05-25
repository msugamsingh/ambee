import 'package:ambee/data/network/network_exception_handler.dart';

class RepoResponse<T> {
  final APIException? error;
  final T? data;

  bool get hasData => data != null && error == null;
  bool get hasError => error != null;

  RepoResponse({this.error, this.data});
}