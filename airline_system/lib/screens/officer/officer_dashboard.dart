import 'package:flutter/material.dart';
import 'add_flight_screen.dart';
import 'update_flight_screen.dart';
import 'delete_flight_screen.dart';

class OfficerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Officer Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddFlightScreen())),
              child: Text("Add Flight"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateFlightScreen())),
              child: Text("Update Flight"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteFlightScreen())),
              child: Text("Delete Flight"),
            ),
          ],
        ),
      ),
    );
  }
}
