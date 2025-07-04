import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class DeleteFlightScreen extends StatefulWidget {
  @override
  _DeleteFlightScreenState createState() => _DeleteFlightScreenState();
}

class _DeleteFlightScreenState extends State<DeleteFlightScreen> {
  final TextEditingController _flightIdController = TextEditingController();

  void deleteFlight() async {
    try {
      await ApiService.deleteFlight(_flightIdController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Flight deleted successfully!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete flight')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Flight")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _flightIdController, decoration: InputDecoration(labelText: "Flight ID")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: deleteFlight, child: Text("Delete Flight")),
          ],
        ),
      ),
    );
  }
}
