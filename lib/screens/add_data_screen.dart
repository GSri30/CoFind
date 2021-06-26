import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class AddDataScreen extends StatefulWidget {
  static const routeName = '/add-data';

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final InstitutionNameController = TextEditingController();

  final PhoneNumberController = TextEditingController();

  final AlternateNumberController = TextEditingController();

  final LocationController = TextEditingController();

  void submitData(BuildContext context) {
    String InstitutionName = InstitutionNameController.text;
    String PhoneNumber = InstitutionNameController.text;
    String AlternateNumber = AlternateNumberController.text;
    String Location = LocationController.text;

    if (InstitutionName.isEmpty || PhoneNumber.isEmpty || Location.isEmpty) {
      return;
    }

    Navigator.of(context).pop();
  }

  var _selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(children: [
            // Resources

            FilterChip(
                selected: _selected,
                label: Text('Oxygen'),
                selectedColor: Colors.lightGreen,
                onSelected: (bool selected) {
                  setState(() {
                    _selected = !_selected;
                  });
                }),

            FilterChip(
                selected: _selected,
                label: Text('Beds'),
                selectedColor: Colors.lightGreen,
                onSelected: (bool selected) {
                  setState(() {
                    _selected = !_selected;
                  });
                }),

            // Instituion name

            TextField(
              decoration: InputDecoration(labelText: 'Institution Name'),
              controller: InstitutionNameController,
            ),
            SizedBox(
              height: 16,
            ),
            // Phone Number
            TextField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              controller: PhoneNumberController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 16,
            ),
            // Alternate Number
            TextField(
              decoration: InputDecoration(labelText: 'Alternate Number'),
              controller: AlternateNumberController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 16,
            ),
            // Location
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              controller: LocationController,
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
