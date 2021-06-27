import 'package:flutter/material.dart';

class DisclaimerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 1,
      child: Text(
        'Data in the listing is verified by volunteers. We do not guarantee of service or stock. If you know any leads for any resources, please help others by adding them using the plus button below',
        style: TextStyle(
          color: Color(0x2C98F0),
        ),
      ),
    );
  }
}
