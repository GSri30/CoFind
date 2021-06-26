import 'package:firebase_database/firebase_database.dart';
import 'package:cofind/data/constants.dart';
import 'package:cofind/models/resource.dart';

final DatabaseReference firebase = FirebaseDatabase.instance.reference();
final DatabaseReference DBrootReference = firebase.reference();
final DatabaseReference Resources = DBrootReference.child('Resources');

class ResourceCRUD {
  static String create(Resource Resource) {
    final DatabaseReference newResource = Resources.push();

    newResource.set({
      'UserID': Resource.UserID,
      'ResourceType': RESOURCE_TYPE_CONVERTER[Resource.ResourceType],
      'InstitutionName': Resource.InstitutionName,
      'PhoneNumber': Resource.PhoneNumber,
      'AlternateNumber': Resource.AlternateNumber,
      'Location': Resource.Location,
      'City': Resource.City,
      'ServiceNote': Resource.ServiceNote,
      'isVerified': Resource.isVerified
    });

    return newResource.key;
  }

  static List<Resource> read(snapshot) {
    List<Resource> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> resources = snapshot.value;
      resources.forEach((resourceID, resource) {
        if (resource['isVerified'] != 'false') {
          result.add(new Resource.dynamic(resource));
        }
      });
    }

    return new List.from(result.reversed);
  }

  static void update(String resourceID, Resource updatedResource) {
    final DatabaseReference resource = Resources.child(resourceID);

    resource.set({
      'UserID': updatedResource.UserID,
      'ResourceType': RESOURCE_TYPE_CONVERTER[updatedResource.ResourceType],
      'InstitutionName': updatedResource.InstitutionName,
      'PhoneNumber': updatedResource.PhoneNumber,
      'AlternateNumber': updatedResource.AlternateNumber,
      'Location': updatedResource.Location,
      'City': updatedResource.City,
      'ServiceNote': updatedResource.ServiceNote,
      'isVerified': updatedResource.isVerified
    });

    return;
  }

  static void delete(String resourceID) async {
    final DatabaseReference resource = Resources.child(resourceID);
    await resource.remove();
  }

  static void verify(String resourceID) {
    final DatabaseReference resource = Resources.child(resourceID);
    resource.update({'isVerified': 'true'});
  }

  static Future<bool> is_verified(String resourceID) async {
    final DatabaseReference isVerified =
        Resources.child(resourceID).child('isVerified');
    bool ok = false;
    isVerified.once().then((value) {
      ok = (value == "true");
    });
    return ok;
  }

  static Future<void> add_servicenote(String resourceID, String note) async {
    final DatabaseReference resource = Resources.child(resourceID);
    await resource.update({'ServiceNote': note});
  }

  static List<Resource> get(snapshot) {
    List<Resource> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> resources = snapshot.value;
      resources.forEach((resourceID, resource) {
        result.add(new Resource.dynamic(resource));
      });
    }

    return new List.from(result.reversed);
  }
}
