// read to use main.dart
import 'package:cofind/screens/approve_volunteers_screen.dart';
import 'package:cofind/screens/auth/auth.dart';
import 'package:cofind/screens/homepage.dart';
import 'package:cofind/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'config/palette.dart';
import 'screens/verify_data_screen.dart';
import 'widgets/tab_bar_screen.dart';
import './screens/add_data_screen.dart';
import './screens/display_data_screen.dart';
import './screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoFind',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.muliTextTheme(),
          accentColor: Palette.orange,
          appBarTheme: const AppBarTheme(
            brightness: Brightness.dark,
            color: Palette.darkBlue,
          ),
        ),
        home: const SplashScreen(),
        routes: {
          AddDataScreen.routeName: (context) => AddDataScreen(),
          DisplayDataScreen.routeName: (context) => DisplayDataScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          VerifyDataScreen.routeName: (context) => VerifyDataScreen(),
          ApproveVolunteersScreen.routeName: (context) =>
              ApproveVolunteersScreen(),
        },
      ),
    );
  }
}
