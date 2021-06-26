import 'package:firebase_database/firebase_database.dart';
import 'package:cofind/data/constants.dart';
import 'package:cofind/models/emergency_contact.dart';

final DatabaseReference firebase = FirebaseDatabase.instance.reference();
final DatabaseReference DBrootReference = firebase.reference();
final DatabaseReference Contacts = DBrootReference.child('Emergency Contacts');

class EmergencyContactCRUD {
  static String create(EmergencyContact contact) {
    final DatabaseReference newContact = Contacts.push();

    newContact.set({'name': contact.name, 'number': contact.number});

    return newContact.key;
  }

  static List<EmergencyContact> read(snapshot) {
    List<EmergencyContact> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> contacts = snapshot.value;
      contacts.forEach((contactID, contact) {
        result.add(new EmergencyContact.dynamic(contact));
      });
    }

    return new List.from(result.reversed);
  }

  static void delete(String contactID) async {
    final DatabaseReference contact = Contacts.child(contactID);
    await contact.remove();
  }
}
