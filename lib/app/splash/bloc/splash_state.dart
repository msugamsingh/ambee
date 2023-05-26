part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final bool listen;
  final String? error;

  const SplashState({
    this.listen = true,
    this.error,
  });

  SplashState copyWith({
    bool? listen,
    String? error,
  }) {
    return SplashState(
      listen: listen ?? this.listen,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        listen,
        error,
      ];
}
