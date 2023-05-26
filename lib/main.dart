import 'package:ambee/app/home/bloc/home_cubit.dart';
import 'package:ambee/app/home/ui/home_page.dart';
import 'package:ambee/app/splash/ui/splash_page.dart';
import 'package:ambee/data/env.dart';
import 'package:ambee/data/routes.dart';
import 'package:ambee/utils/values/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        title: Env.title,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        initialRoute: Routes.splash,
        routes: {
          Routes.splash: (context) => const SplashPage(),
          Routes.home: (context) => const HomePage(),
        },
      ),
    );
  }
}
