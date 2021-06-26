import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:cofind/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

final DatabaseReference firebase = FirebaseDatabase.instance.reference();
final DatabaseReference DBrootReference = firebase.reference();
final DatabaseReference Users = DBrootReference.child('Users');

class UserCRUD {
  static user get(BuildContext context) {
    User ctxuser = context.getSignedInUser();
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

    specificUser.set({
      'userName': user.name != null ? user.name : "User",
      'userEmail': user.emailID,
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
    await specificUser.once().then((user) {
      if (user != null) ok = (user.value['isAdmin'] == "true");
    });
    return ok;
  }

  static void update(BuildContext context,
      {String new_display_name = null, String new_email = null}) {
    context.getSignedInUser().when((user) {
      if (new_email != null) {
        user.updateEmail(new_email);
      }
      if (new_display_name != null) {
        dynamic updatedInfo = new UserUpdateInfo();

        updatedInfo.displayName = new_display_name;
        user.updateProfile(updatedInfo);
      }

      user.reload();
    }, empty: () {}, initializing: () {});
  }

  static void update_index(user user) async {
    final DatabaseReference specificUser = Users.child(user.uid);

    specificUser.update({'userName': user.name, 'userEmail': user.emailID});
  }

  static void make_admin(String uid) {
    final DatabaseReference specificUser = Users.child(uid);

    specificUser.update({'isAdmin': 'true'});
  }

  static List<user> get_users(snapshot) {
    List<user> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> users = snapshot.value;
      users.forEach((userID, usr) {
        result.add(new user.dynamic(userID, usr));
      });
    }

    return new List.from(result.reversed);
  }
}
