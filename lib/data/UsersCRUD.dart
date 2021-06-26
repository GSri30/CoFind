import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:cofind/models/user.dart';

final DatabaseReference firebase = FirebaseDatabase.instance.reference();
final DatabaseReference DBrootReference = firebase.reference();
final DatabaseReference Users = DBrootReference.child('Users');

class UserCRUD {
  static Future<user> get(BuildContext context) async {
    final ctxuser = context.getSignedInUser();
    user result;

    ctxuser.when((ctxuser) {
      result = user(
          name: ctxuser.displayName,
          emailID: ctxuser.email,
          hasVerifiedEmail: ctxuser.isEmailVerified.toString(),
          uid: ctxuser.uid);
    }, empty: () {}, initializing: () {});

    return result;
  }

  // static void map(user user, List<String> resourcesID) {
  //   final DatabaseReference specificUser = Users.child(user.uid);
  //   final DatabaseReference specificUserResources =
  //       specificUser.child("Resources");

  //   int n = resourcesID.length;
  //   List<DatabaseReference> newResourceRefList = [];
  //   for (int i = 0; i < n; i++) {
  //     newResourceRefList.add(specificUserResources.child(resourcesID[i]));
  //   }

  //   for (int i = 0; i < n; i++) {
  //     newResourceRefList[i].set({'isVerified': 'false', 'isRejected': 'false'});
  //   }
  // }

  static void create(user user) {
    final DatabaseReference specificUser = Users.child(user.uid);
    final DatabaseReference specificUserResources =
        specificUser.child("Resources");

    specificUser.set({
      'userName': user.name,
      'userEmail': user.emailID,
      'hasEmailVerified': user.hasVerifiedEmail.toString(),
      'isAdmin': 'false',
    });
  }

  // static void read(String uid) {
  //   user usr;
  //   Users.child(uid).once().then((value) {
  //     // usr = value as user;
  //   });
  // }

  static Future<bool> is_admin(String uid) async {
    final DatabaseReference specificUser = Users.child(uid);
    bool ok = false;
    specificUser.once().then((value) {
      if (value != null) ok = (value == "true");
    });
    return ok;
  }
}
