import 'package:flutter/material.dart';
import '../models/flight_model.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;
  final VoidCallback onTap;

  FlightCard({required this.flight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          "${flight.flightNumber} - ${flight.origin} to ${flight.destination}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Departure: ${flight.departureTime}"),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}