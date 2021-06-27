import 'package:cofind/screens/auth/sign_in_up.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'decoration_functions.dart';
import 'title.dart';

class Register extends StatelessWidget {
  Register({Key key, this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  final emailField = new EmailTextFormField(
    style: const TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    decoration: registerInputDecoration(hintText: 'Email'),
  );

  final passwordField = PasswordTextFormField(
    style: const TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    decoration: registerInputDecoration(hintText: 'Password'),
  );
  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.isSubmitting();
    return SignInForm(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginTitle(
                  title: 'Create\nAccount',
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: emailField,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: passwordField,
                  ),
                  SignUpBar(
                    label: 'Sign up',
                    isLoading: isSubmitting,
                    onPressed: () {
                      context.registerWithEmailAndPassword();
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        onSignInPressed?.call();
                      },
                      child: const Text(
                        'Already have an account? Sign in here!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
