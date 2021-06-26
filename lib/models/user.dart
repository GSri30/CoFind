class user {
  String name = "User", emailID = "", hasVerifiedEmail = "false", uid = "";

  user({this.name, this.emailID, this.hasVerifiedEmail, this.uid});

  user.dynamic(String userID, dynamic data) {
    this.uid = userID;
    this.emailID = data['userEmail'];
    if (data['username'] != null) this.name = data['userName'];
  }
}
