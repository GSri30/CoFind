import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class UserCRUD {
  static Map<String, String> read(BuildContext context) {
    final user = context.getSignedInUser();
    Map<String, String> result = {};
    user.when((user) {
      result["uid"] = user.uid;
      result['email'] = user.email;
      result["verified"] = user.isEmailVerified.toString();
    }, empty: () {}, initializing: () {});
    return result;
  }
}
