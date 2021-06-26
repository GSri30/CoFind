// read to use main.dart
import 'package:flutter/material.dart';
import 'widgets/tab_bar_screen.dart';
import './screens/add_data_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoFind',
      theme: ThemeData(
        // this can be changed later

        primarySwatch: Colors.blue,
        accentColor: Colors.black,
      ),
      home: TabBarScreen(),
      routes: {
        AddDataScreen.routeName: (context) => AddDataScreen(),
      },
    );
  }
}
