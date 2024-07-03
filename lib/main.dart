import 'package:flutter/material.dart';
import 'package:whatsapp/routes/on_generate_routes.dart';

import 'features/app/splash/splash_screen.dart';
import 'features/app/theme/style.dart';
import 'main_injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        dialogBackgroundColor: appBarColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      initialRoute: "/",
      onGenerateRoute: OnGenerateRoutes.route,
      routes: {
        "/": (context) => const SplashScreen(),
      },
    );
  }
}
