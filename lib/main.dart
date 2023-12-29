import 'package:flutter/material.dart';
import 'package:roasty2/screen/detail_page.dart';
import 'package:roasty2/screen/home_page.dart';
import 'package:roasty2/screen/home_screen.dart';
import 'package:roasty2/screen/splash_screen.dart';
import 'package:roasty2/theme/styles.dart';
import 'package:roasty2/screen/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      title: 'Roasty',
      darkTheme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColorDark,
          onPrimary: Colors.white,
          secondary: secondaryColorDark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColorDark,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(elevation: 0),
        textTheme: myTextTheme,
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(elevation: 0),
        textTheme: myTextTheme,
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen.routeName: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        SearchScreen.routeName: (context) => const SearchScreen(),
      },
    );
  }
}
