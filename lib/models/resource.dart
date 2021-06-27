class Resource {
  String UserID,
      ResourceType,
      InstitutionName,
      PhoneNumber,
      AlternateNumber,
      Location,
      City,
      ServiceNote,
      isVerified,
      ResourceID = "";

  Resource(
      {this.UserID,
      this.ResourceType,
      this.InstitutionName,
      this.PhoneNumber,
      this.AlternateNumber,
      this.Location,
      this.City,
      this.ServiceNote,
      this.isVerified});

  Resource.dynamic(String resourceID, dynamic data) {
    this.UserID = data['UserID'];
    this.ResourceType = data['ResourceType'];
    this.InstitutionName = data['InstitutionName'];
    this.PhoneNumber = data['PhoneNumber'];
    this.AlternateNumber = data['AlternateNumber'];
    this.Location = data['Location'];
    this.City = data['City'];
    this.ServiceNote = data['ServiceNote'];
    this.isVerified = data['isVerified'];
    this.ResourceID = resourceID;
  }
}
