import 'package:airline_system/screens/officer/officer_dashboard.dart';
import 'package:flutter/material.dart';
import '../../utils/auth_helper.dart';
import 'flight_list_screen.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<bool> isOfficer() async {
    String? role = await AuthHelper.getUserRole();
    print("role is what ? $role");
    return role == "officer";
  }

  void logoutUser(BuildContext context) async {
    await AuthHelper.clearToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logoutUser(context),
          ),
        ],
      ),
      body: FutureBuilder<bool>(
        future: isOfficer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final bool isOfficer = snapshot.data ?? false;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Flight List Screen for all users
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlightListScreen()),
                  );
                },
                child: Text("View Flights"),
              ),
              
              // Show Officer Dashboard if user is an officer
              if (isOfficer) ...[
                Divider(),
                Text("Officer Dashboard:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(child: OfficerDashboard()),
              ],
            ],
          );
        },
      ),
    );
  }
}
  