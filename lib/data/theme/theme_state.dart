part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final bool darkTheme;
  final ThemeData? theme;

  const ThemeState({this.darkTheme = true, this.theme});

  ThemeState copyWith({bool? darkTheme, ThemeData? theme}) {
    return ThemeState(
      darkTheme: darkTheme ?? this.darkTheme,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [darkTheme, theme];
}
