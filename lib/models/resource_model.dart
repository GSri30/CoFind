class Resource {
  String institutionName;
  String phoneNumber;
  String alternateNumber;
  String location;
  String serviceNote;
  String city;
  bool isVerified;
  Map<String, bool> resourcesAvailable;
  String userID;

  Resource({
    this.institutionName,
    this.phoneNumber,
    this.alternateNumber,
    this.location,
    this.serviceNote,
    this.city,
    this.resourcesAvailable,
    this.isVerified,
    this.userID,
  });
}

List<Resource> DUMMY_DATA = [
  Resource(
    institutionName: 'Microgene Labs',
    phoneNumber: '9999999999',
    alternateNumber: '',
    location: 'near IIIT Bangalore college',
    serviceNote: 'Available 24/7, can help within 30 mins',
    city: 'Bangalore',
    resourcesAvailable: {
      'Oxygen': false,
      'Ambulance': false,
      'Blood': false,
      'Hospital': false,
      'Doctor': false,
      'Medication': false,
      'Food': false,
      'Quarantine': false,
      'Funeral': false,
    },
    isVerified: true,
    userID: 'Random',
  ),
];
