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
          VolunteerApprovalCard(),
          VolunteerApprovalCard(),
          VolunteerApprovalCard(),
          VolunteerApprovalCard(),
        ],
      ),
    );
  }
}

class VolunteerApprovalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.1)),
      ),
      child: ListTile(
        title: Text('User Name'),
        subtitle: Text('email'),
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
