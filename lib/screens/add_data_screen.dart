import 'package:flutter/material.dart';
import '../widgets/resource_filter_chip.dart';

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

    if (institutionName.isEmpty || phoneNumber.isEmpty || location.isEmpty) {
      return;
    }

    print(resourceFilter);

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
