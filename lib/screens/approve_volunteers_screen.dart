import 'package:flutter/material.dart';

class ApproveVolunteersScreen extends StatelessWidget {
  static const String routeName = '/approve-volunteers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteers request'),
      ),
      body: ListView(
        children: [
          VolunteerApprovalCard('Divyam', 'divyam.agrawal@iiitb.ac.in'),
          VolunteerApprovalCard('Jagadesh', 'Siva.jagadesh@iiitb.ac.in'),
          VolunteerApprovalCard('Harsha', 'g.sriharsha@iiitb.ac.in'),
          VolunteerApprovalCard('Nikhil', 'nikhil.agarwal@iiitb.ac.in'),
          VolunteerApprovalCard('Yasho', 'Yashovardhan.Reddy@iiitb.ac.in'),
        ],
      ),
    );
  }
}

class VolunteerApprovalCard extends StatelessWidget {
  final String name;
  final String email;

  VolunteerApprovalCard(this.name, this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.1)),
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
          email,
          style: TextStyle(fontSize: 11),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                child: Icon(
                  Icons.done,
                  color: Colors.lightGreen,
                ),
                onPressed: () {}),
            SizedBox(
              width: 16,
            ),
            TextButton(
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
