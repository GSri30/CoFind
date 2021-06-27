class EmergencyContact {
  String name;
  String number;
  String city;

  EmergencyContact({this.name, this.number, this.city});

  EmergencyContact.dynamic(dynamic data) {
    this.name = data['name'];
    this.number = data['number'];
    this.city = data['city'];
  }
}
