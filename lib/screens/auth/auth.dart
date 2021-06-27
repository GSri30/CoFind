import 'package:animations/animations.dart';
import 'package:cofind/config/palette.dart';
import 'package:cofind/screens/auth/register.dart';
import 'package:cofind/screens/auth/sign_in.dart';
import 'package:cofind/screens/background_painter.dart';
import 'package:cofind/widgets/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import '../../data/UsersCRUD.dart';
import '../../models/user.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LitAuth.custom(
        errorNotification: const NotificationConfig(
          backgroundColor: Palette.darkBlue,
          icon: Icon(
            Icons.error_outline,
            color: Colors.deepOrange,
            size: 32,
          ),
        ),
        successNotification: const NotificationConfig(
          backgroundColor: Palette.darkBlue,
          icon: Icon(
            Icons.check,
            color: Colors.white,
            size: 32,
          ),
        ),
        onAuthSuccess: () {
          Navigator.of(context).pushReplacement(TabBarScreen.route);

          String currentEmail;
          String currentID;
          String currentName;

          final currentUser = context.getSignedInUser();
          currentUser.when(
            (user) {
              currentEmail = user.email;
              currentID = user.uid;
              currentName = user.displayName;
            },
            empty: () => print("NO USER"),
            initializing: () => print("Something Went Wrong"),
          );

          user newUser = user(
            emailID: currentEmail,
            name: currentName,
            uid: currentID,
          );

          UserCRUD.create(newUser);
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(
                  animation: _controller,
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ValueListenableBuilder<bool>(
                  valueListenable: showSignInPage,
                  builder: (context, value, child) {
                    return SizedBox.expand(
                      child: PageTransitionSwitcher(
                        reverse: !value,
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder:
                            (child, animation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            fillColor: Colors.transparent,
                            child: child,
                          );
                        },
                        child: value
                            ? SignIn(
                                key: const ValueKey('SignIn'),
                                onRegisterClicked: () {
                                  context.resetSignInForm();
                                  showSignInPage.value = false;
                                  _controller.forward();
                                },
                              )
                            : Register(
                                key: const ValueKey('Register'),
                                onSignInPressed: () {
                                  context.resetSignInForm();
                                  showSignInPage.value = true;
                                  _controller.reverse();
                                },
                              ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
