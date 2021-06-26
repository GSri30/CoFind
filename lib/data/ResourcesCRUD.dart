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
}
