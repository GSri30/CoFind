import 'package:flutter/material.dart';
import '../widgets/resource_filter_chip.dart';
import '../models/resource.dart';
import 'package:cofind/data/UsersCRUD.dart';
import 'package:cofind/data/ResourcesCRUD.dart';
import 'package:cofind/data/Utils.dart';

class AddDataScreen extends StatelessWidget {
  static const routeName = '/add-data';
  final institutionNameController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final alternateNumberController = TextEditingController();

  final locationController = TextEditingController();

  void submitData(BuildContext context) {
    String institutionName = institutionNameController.text;
    String phoneNumber = phoneNumberController.text;
    String alternateNumber = alternateNumberController.text;
    String location = locationController.text;

    if (!Utils.has_resources(resourceFilter) ||
        institutionName.isEmpty ||
        phoneNumber.isEmpty ||
        location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Hey CoFind'er! Please fill all the details!")));
      return;
    }
    if (alternateNumber.isEmpty) {
      alternateNumber = "";
    }

    final current_user = UserCRUD.read(context);
    List<String> Acknowledgements = [];
    //(?)
    final City = "Bangalore";

    resourceFilter.forEach((resource_type, is_available) {
      if (is_available) {
        String acknowledgement = ResourceCRUD.create(Resource(
            UserID: current_user['uid'],
            ResourceType: resource_type,
            InstitutionName: institutionName,
            PhoneNumber: phoneNumber,
            AlternateNumber: alternateNumber,
            Location: location,
            City: City,
            ServiceNote: "",
            isVerified: "false"));

        Acknowledgements.add(acknowledgement);
      }
    });

    for (String acknowledgement in Acknowledgements) {
      print("\nSuccessfully submitted data! Id : ${acknowledgement}");
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Hey CoFind'er! Successfully added ${Utils.available_resources(resourceFilter)} resource(s)")));

    Navigator.of(context).pop();
  }

  final Map<String, bool> resourceFilter = {
    'Oxygen': false,
    'Ambulance': false,
    'Blood': false,
    'Hospital': false,
    'Doctor': false,
    'Medication': false,
    'Food': false,
    'Quarantine': false,
    'Funeral': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Resources'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(children: [
            // Resources

            Container(
              width: double.infinity,
              child: Text(
                'Resources',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            SizedBox(
              height: 8,
            ),
            ResourceFilterChip(resourceFilter),
            SizedBox(
              height: 16,
            ),

            // Instituion name

            TextField(
              decoration: InputDecoration(labelText: 'Institution Name'),
              controller: institutionNameController,
            ),
            SizedBox(
              height: 16,
            ),
            // Phone Number
            TextField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 16,
            ),
            // Alternate Number
            TextField(
              decoration: InputDecoration(labelText: 'Alternate Number'),
              controller: alternateNumberController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 16,
            ),
            // Location
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              controller: locationController,
            ),
            SizedBox(
              height: 16,
            ),
            // Submit button
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text('SUBMIT'),
        onPressed: () {
          submitData(context);
        },
      ),
    );
  }
}
