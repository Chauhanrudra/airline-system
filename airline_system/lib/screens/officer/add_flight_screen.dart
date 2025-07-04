import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class AddFlightScreen extends StatefulWidget {
  @override
  _AddFlightScreenState createState() => _AddFlightScreenState();
}

class _AddFlightScreenState extends State<AddFlightScreen> {
  final TextEditingController _flightNumberController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _departureTimeController = TextEditingController();
  final TextEditingController _arrivalTimeController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _availableSeatsController = TextEditingController();

  void addFlight() async {
    if (_flightNumberController.text.isEmpty ||
        _originController.text.isEmpty ||
        _destinationController.text.isEmpty ||
        _departureTimeController.text.isEmpty ||
        _arrivalTimeController.text.isEmpty ||
        _seatsController.text.isEmpty ||
        _availableSeatsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    try {
      await ApiService.addFlight({
        'flightNumber': _flightNumberController.text,
        'origin': _originController.text,
        'destination': _destinationController.text,
        'departureTime': _departureTimeController.text,
        'arrivalTime': _arrivalTimeController.text,
        'seats': int.parse(_seatsController.text),
        'availableSeats': int.parse(_availableSeatsController.text),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Flight added successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add flight: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Flight")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _flightNumberController, decoration: InputDecoration(labelText: "Flight Number")),
              TextField(controller: _originController, decoration: InputDecoration(labelText: "Origin")),
              TextField(controller: _destinationController, decoration: InputDecoration(labelText: "Destination")),
              TextField(controller: _departureTimeController, decoration: InputDecoration(labelText: "Departure Time")),
              TextField(controller: _arrivalTimeController, decoration: InputDecoration(labelText: "Arrival Time")),
              TextField(
                controller: _seatsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Total Seats"),
              ),
              TextField(
                controller: _availableSeatsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Available Seats"),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: addFlight, child: Text("Add Flight")),
            ],
          ),
        ),
      ),
    );
  }
}
