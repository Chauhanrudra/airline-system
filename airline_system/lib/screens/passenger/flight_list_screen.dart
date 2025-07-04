import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../widgets/flight_card.dart';
import 'seat_booking_screen.dart';

class FlightListScreen extends StatefulWidget {
  @override
  _FlightListScreenState createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  List<dynamic> flights = [];

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  void fetchFlights() async {
    try {
      final data = await ApiService.fetchFlights();
      setState(() => flights = data);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to fetch flights')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Flights")),
      body: flights.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                return FlightCard(
                  flight: flight,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatBookingScreen(
                            flightId: flight.id), // Use flight.id
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
