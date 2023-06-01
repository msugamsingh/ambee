import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/app/home/model/weather_data_model.dart';
import 'package:ambee/app/home/repo/home_repo.dart';
import 'package:ambee/app/home/ui/home_page.dart';
import 'package:ambee/app/home/widget/location_field_bottomsheet.dart';
import 'package:ambee/data/response/repo_response.dart';
import 'package:ambee/utils/values/app_icons.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  var json = {
    "lat": 12.97,
    "lon": 77.59,
    "timezone": "Asia/Kolkata",
    "timezone_offset": 19800,
    "current": {
      "dt": 1685373564,
      "sunrise": 1685319756,
      "sunset": 1685365901,
      "temp": 29.53,
      "feels_like": 31.28,
      "pressure": 1015,
      "humidity": 56,
      "dew_point": 19.83,
      "uvi": 0,
      "clouds": 40,
      "visibility": 6000,
      "wind_speed": 1.03,
      "wind_deg": 0,
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "scattered clouds",
          "icon": "03n"
        }
      ]
    },
    "hourly": [
      {
        "dt": 1685372400,
        "temp": 29.53,
        "feels_like": 31.28,
        "pressure": 1015,
        "humidity": 56,
        "dew_point": 19.83,
        "uvi": 0,
        "clouds": 40,
        "visibility": 10000,
        "wind_speed": 2.86,
        "wind_deg": 234,
        "wind_gust": 4.12,
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03n"
          }
        ],
        "pop": 0.49
      },
      {
        "dt": 1685376000,
        "temp": 29.17,
        "feels_like": 30.42,
        "pressure": 1014,
        "humidity": 54,
        "dew_point": 18.91,
        "uvi": 0,
        "clouds": 51,
        "visibility": 10000,
        "wind_speed": 2.22,
        "wind_deg": 206,
        "wind_gust": 3.43,
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04n"
          }
        ],
        "pop": 0.52
      },
    ],
    "daily": [
      {
        "dt": 1685341800,
        "sunrise": 1685319756,
        "sunset": 1685365901,
        "moonrise": 1685347980,
        "moonset": 1685304120,
        "moon_phase": 0.3,
        "temp": {
          "day": 32.39,
          "min": 23.63,
          "max": 33.69,
          "night": 27.28,
          "eve": 28.91,
          "morn": 23.63
        },
        "feels_like": {
          "day": 31.82,
          "night": 28.05,
          "eve": 29.43,
          "morn": 23.82
        },
        "pressure": 1010,
        "humidity": 34,
        "dew_point": 14.68,
        "wind_speed": 3.93,
        "wind_deg": 292,
        "wind_gust": 5.18,
        "weather": [
          {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
          }
        ],
        "clouds": 44,
        "pop": 0.63,
        "rain": 0.68,
        "uvi": 12.05
      },
      {
        "dt": 1685428200,
        "sunrise": 1685406154,
        "sunset": 1685452319,
        "moonrise": 1685437140,
        "moonset": 1685392620,
        "moon_phase": 0.33,
        "temp": {
          "day": 30.67,
          "min": 23.75,
          "max": 32.62,
          "night": 23.75,
          "eve": 25.68,
          "morn": 24.5
        },
        "feels_like": {
          "day": 30.49,
          "night": 23.98,
          "eve": 25.82,
          "morn": 24.6
        },
        "pressure": 1011,
        "humidity": 40,
        "dew_point": 15.87,
        "wind_speed": 5.24,
        "wind_deg": 65,
        "wind_gust": 8.82,
        "weather": [
          {
            "id": 501,
            "main": "Rain",
            "description": "moderate rain",
            "icon": "10d"
          }
        ],
        "clouds": 88,
        "pop": 0.8,
        "rain": 3.3,
        "uvi": 12.4
      },
    ],
  };

  late final MockHomeCubit mockCubit;
  late final MockHomeRepo repo;
  late TextEditingController mockTextEditingController;

  final weather = WeatherData.fromJson(json);
  Future<RepoResponse<WeatherData>> weatherDataFuture =
  Future<RepoResponse<WeatherData>>.value(
      RepoResponse<WeatherData>(data: weather));

  setUpAll(() {
    mockCubit = MockHomeCubit();
    repo = MockHomeRepo();
    mockTextEditingController = TextEditingController();

    registerFallbackValue(HomeStateFake());
  });

  blocTest(
    'HomeBloc test',
    build: () => mockCubit,
    act: (mockCubit) {
      // stub
      when(() => repo.getWeather(lat: 12, lon: 77))
          .thenAnswer((_) async => weatherDataFuture);
      when(() => mockCubit.state).thenAnswer((_) => const HomeState());
      expect(mockCubit.state, const HomeState());
      when(() => mockCubit.getWeather(12, 77)).thenAnswer((_) async {});
      // mockCubit.emit(HomeState().copyWith(weatherData: weather));

      when(() => mockCubit.state).thenAnswer(
              (invocation) => const HomeState().copyWith(weatherData: weather));

      expect(mockCubit.state.weatherData, weather);

      when(mockCubit.getWindSpeed).thenAnswer((_) => '1.03 m/s');
      verifyNever(() => mockCubit.getWeather(12, 77));
      mockCubit.getWeather(12, 77);
      expect(mockCubit.getWindSpeed(), '1.03 m/s');
      verify(() => mockCubit.getWeather(12, 77)).called(1);
    },
  );

  testWidgets('Home Page Test', (tester) async {
    // stub
    when(() => mockCubit.state)
        .thenAnswer((invocation) =>
        const HomeState().copyWith(
          currentWeather: weather.current?.weather?.first,
          weatherData: weather,
        ));
    expect(mockCubit.state.weatherData, weather);

    when(mockCubit.getWindSpeed).thenAnswer((_) => '1.03 m/s');
    when(mockCubit.getHumidity).thenReturn('50%');
    when(mockCubit.getRainPop).thenReturn('30%');
    when(mockCubit.getUVI).thenReturn('3');

    tester.view.physicalSize = const Size(1200, 1800);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<HomeCubit>.value(
          value: mockCubit,
          child: Scaffold(body: HomePage()),
        ),
      ),
    );

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('1.03 m/s'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.byIcon(AppIcons.location), findsOneWidget);
    expect(find.text(mockCubit.state.currentWeather!.main!), findsOneWidget);
  });

  testWidgets('LocationBottomSheet test', (WidgetTester tester) async {
    // Stub the necessary methods or provide desired behavior using mocktail
    when(() => mockCubit.state)
        .thenAnswer((invocation) =>
        const HomeState().copyWith(
          currentWeather: weather.current?.weather?.first,
          weatherData: weather,
        ));
    when(() => mockCubit.locationController)
        .thenAnswer((invocation) => mockTextEditingController);
    when(() => mockCubit.predict(any())).thenAnswer((_) {
      // Simulate the loading of predictions
      mockCubit.emit(const HomeState().copyWith(loadingPredictions: true));

      // Delay the emission of the next state to simulate asynchronous behavior
      Future.delayed(const Duration(milliseconds: 500), () {
        mockCubit.emit(const HomeState().copyWith(
          loadingPredictions: false,
          locationPredictions: [
            const AutocompletePrediction(
                fullText: 'Location 1',
                placeId: '',
                primaryText: '',
                secondaryText: ''),
            const AutocompletePrediction(
                fullText: 'Location 2',
                placeId: '',
                primaryText: '',
                secondaryText: ''),
            const AutocompletePrediction(
                fullText: 'Location 3',
                placeId: '',
                primaryText: '',
                secondaryText: ''),
          ],
        ));
      });

      return null;
    });

    when(() => mockCubit.onPredictionSelect('Location 1')).thenAnswer(
            (invocation) async =>
            mockCubit.emit(const HomeState().copyWith(location: 'Location 1')));
    when(() => mockCubit.state)
        .thenAnswer((invocation) =>
        const HomeState().copyWith(
          loadingPredictions: false,
          locationPredictions: [
            const AutocompletePrediction(
                fullText: 'Location 1',
                placeId: '',
                primaryText: '',
                secondaryText: ''),
            const AutocompletePrediction(
                fullText: 'Location 2',
                placeId: '',
                primaryText: '',
                secondaryText: ''),
            const AutocompletePrediction(
                fullText: 'Location 3',
                placeId: '',
                primaryText: '',
                secondaryText: ''),
          ],
        ));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<HomeCubit>.value(
            value: mockCubit,
            child: Builder(
              builder: (context) {
                // Assign the mock TextEditingController to the cubit
                return const LocationBottomSheet();
              },
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    // Verify the loaded predictions
    expect(find.byType(ListTile), findsNWidgets(3));

    // 2, 1 for the title and one for the field
    expect(find.text('Location'), findsNWidgets(2));
    expect(find.byType(TextField), findsOneWidget);

    await tester.tap(find.text('Location 1'));
    await tester.pumpAndSettle();

    verify(() => mockCubit.onPredictionSelect('Location 1')).called(1);
  });
}

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class HomeStateFake extends Fake implements HomeState {}

class MockHomeRepo extends Mock implements HomeRepository {}
