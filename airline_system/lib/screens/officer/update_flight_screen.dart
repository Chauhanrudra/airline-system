import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class UpdateFlightScreen extends StatefulWidget {
  @override
  _UpdateFlightScreenState createState() => _UpdateFlightScreenState();
}

class _UpdateFlightScreenState extends State<UpdateFlightScreen> {
  final TextEditingController _flightIdController = TextEditingController();
  final TextEditingController _flightNumberController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _departureTimeController = TextEditingController();
  final TextEditingController _arrivalTimeController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _availableSeatsController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  void updateFlight() async {
    try {
      await ApiService.updateFlight(_flightIdController.text, {
        'flightNumber': _flightNumberController.text,
        'origin': _originController.text,
        'destination': _destinationController.text,
        'departureTime': _departureTimeController.text,
        'arrivalTime': _arrivalTimeController.text,
        'seats': int.tryParse(_seatsController.text) ?? 0,
        'availableSeats': int.tryParse(_availableSeatsController.text) ?? 0,
        'status': _statusController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Flight updated successfully!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update flight')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Flight")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _flightIdController, decoration: InputDecoration(labelText: "Flight ID")),
              TextField(controller: _flightNumberController, decoration: InputDecoration(labelText: "Flight Number")),
              TextField(controller: _originController, decoration: InputDecoration(labelText: "Origin")),
              TextField(controller: _destinationController, decoration: InputDecoration(labelText: "Destination")),
              TextField(controller: _departureTimeController, decoration: InputDecoration(labelText: "Departure Time")),
              TextField(controller: _arrivalTimeController, decoration: InputDecoration(labelText: "Arrival Time")),
              TextField(controller: _seatsController, decoration: InputDecoration(labelText: "Total Seats"), keyboardType: TextInputType.number),
              TextField(controller: _availableSeatsController, decoration: InputDecoration(labelText: "Available Seats"), keyboardType: TextInputType.number),
              TextField(controller: _statusController, decoration: InputDecoration(labelText: "Status")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: updateFlight, child: Text("Update Flight")),
            ],
          ),
        ),
      ),
    );
  }
}
