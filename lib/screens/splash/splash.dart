import 'dart:async';

import 'package:cofind/screens/auth/auth.dart';
import 'package:cofind/screens/splash/splash_background.dart';
import 'package:cofind/widgets/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);
  bool _state = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
    _controller.forward();
    Timer(
      Duration(seconds: 3),
      () => setState(
        () {
          _state = true;
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    if (_state) {
      final user = context.watchSignedInUser();
      user.map(
        (value) {
          _navigateToHomeScreen(context);
        },
        empty: (_) {
          _navigateToAuthScreen(context);
        },
        initializing: (_) {},
      );
    }
    return Scaffold(
        // body: Stack(
        //   children: [
        // Image.asset('safety.png'),
        // SizedBox.expand(
        //   child: Image.asset('')

        //   // CustomPaint(
        //   //   painter: SplashBackgroundPainter(
        //   //     animation: _controller,
        //   //   ),
        //   // ),
        // ),
        // Center(
        //   child: CircularProgressIndicator(),
        // ),
        // ],
        // ),
        body: !isLandscape
            ? SafeArea(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/splash.png'),
                        Text(
                          'CoFind',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Find resources at lighting speed!',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ]),
                ),
              )
            : SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/splash.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CoFind',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Find resources at lighting speed!',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ));
  }

  void _navigateToAuthScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(AuthScreen.route),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(TabBarScreen.route),
    );
  }
}
