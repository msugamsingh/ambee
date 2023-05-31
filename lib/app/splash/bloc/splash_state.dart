part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final bool listen;
  final String? error;
  final double? lat;
  final double? long;


  /// Represents the state of the splash screen in the application.
  ///
  /// The [listen] flag determines whether the state should listen for updates or not.
  /// The [error] field holds an optional error message if an error occurred during the splash screen.
  /// The [lat] and [long] fields store the latitude and longitude coordinates for the device's location.

  const SplashState({this.listen = true, this.error, this.lat, this.long});

  /// Returns a new [SplashState] object with the updated fields.
  SplashState copyWith({
    bool? listen,
    String? error,
    double? lat,
    double? long,
  }) {
    return SplashState(
      listen: listen ?? this.listen,
      error: error,
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
