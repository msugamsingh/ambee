part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final bool darkTheme;

  const ThemeState({this.darkTheme = true});

  ThemeState copyWith({bool? darkTheme}) {
    return ThemeState(darkTheme: darkTheme ?? this.darkTheme);
  }

  @override
  List<Object> get props => [darkTheme];
}
