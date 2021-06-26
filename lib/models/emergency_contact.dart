class EmergencyContact {
  String name;
  String number;

  EmergencyContact({this.name, this.number});

  EmergencyContact.dynamic(dynamic data) {
    this.name = data['name'];
    this.number = data['number'];
  }
}

List<EmergencyContact> DUMMY_DATA = [
  EmergencyContact(
    name: 'Nikhil',
    number: '8758360306',
  ),
  EmergencyContact(
    name: 'Jaggu',
    number: '100',
  ),
];
