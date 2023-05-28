part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final bool listen;
  final String? error;
  final double? lat;
  final double? long;

  const SplashState({this.listen = true, this.error, this.lat, this.long});

  SplashState copyWith({
    bool? listen,
    String? error,
    double? lat,
    double? long,
  }) {
    return SplashState(
      listen: listen ?? this.listen,
      error: error ?? this.error,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  @override
  List<Object?> get props => [
        listen,
        error,
        lat,
        long,
      ];
}
