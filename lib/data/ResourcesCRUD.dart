import 'package:cofind/models/crowd.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cofind/data/constants.dart';
import 'package:cofind/models/resource.dart';

final DatabaseReference firebase = FirebaseDatabase.instance.reference();
final DatabaseReference DBrootReference = firebase.reference();
final DatabaseReference Resources = DBrootReference.child('Resources');
final DatabaseReference Requests = DBrootReference.child('Reqests');
final DatabaseReference CrowdRef = DBrootReference.child('Crowd');

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
    await isVerified.once().then((is_verified) {
      ok = (is_verified.value == "true");
    });
    return ok;
  }

  static void add_servicenote(String resourceID, String note) {
    final DatabaseReference resource = Resources.child(resourceID);
    resource.update({'ServiceNote': note});
  }

  static List<Resource> get_all(snapshot) {
    List<Resource> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> resources = snapshot.value;
      resources.forEach((resourceID, resource) {
        result.add(new Resource.dynamic(resourceID, resource));
      });
    }

    return new List.from(result.reversed);
  }

  static List<Resource> get_verified(snapshot) {
    List<Resource> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> resources = snapshot.value;
      resources.forEach((resourceID, resource) {
        if (resource['isVerified'] != 'false') {
          result.add(new Resource.dynamic(resourceID, resource));
        }
      });
    }

    return new List.from(result.reversed);
  }

  static List<Resource> get_verified_city(snapshot, city) {
    List<Resource> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> resources = snapshot.value;
      resources.forEach((resourceID, resource) {
        if (resource['isVerified'] != 'false' &&
            (city == null || resource['City'] == city)) {
          result.add(new Resource.dynamic(resourceID, resource));
        }
      });
    }

    return new List.from(result.reversed);
  }

  static List<Resource> get_user_specific(String uid, snapshot) {
    List<Resource> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> resources = snapshot.value;
      resources.forEach((resourceID, resource) {
        if (resource['UserID'] == uid) {
          result.add(new Resource.dynamic(resourceID, resource));
        }
      });
    }

    return new List.from(result.reversed);
  }

  static List<Resource> get_unverified(snapshot) {
    List<Resource> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> resources = snapshot.value;
      resources.forEach((resourceID, resource) {
        if (resource['isVerified'] != 'true') {
          result.add(new Resource.dynamic(resourceID, resource));
        }
      });
    }

    return new List.from(result.reversed);
  }

  static String request(Resource Resource) {
    final DatabaseReference reqResource = Requests.push();

    reqResource.set({
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

    return reqResource.key;
  }

  static List<Crowd> get_crowd_data(snapshot) {
    List<Crowd> result = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> crowd = snapshot.value;
      crowd.forEach((pincode, crowd) {
        result.add(new Crowd(
            pincode: pincode,
            lastUpdatedAt: crowd['lastUpdatedAt'],
            population: crowd['population']));
      });
    }

    return new List.from(result.reversed);
  }
}
