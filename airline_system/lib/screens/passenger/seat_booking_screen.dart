import 'package:airline_system/widgets/seat_card.dart';
import 'package:flutter/material.dart';
import '../../models/seat_model.dart';
import '../../services/api_service.dart';

class SeatBookingScreen extends StatefulWidget {
  final String flightId;

  SeatBookingScreen({required this.flightId});

  @override
  _SeatBookingScreenState createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  List<Seat> seats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSeats();
  }

  void fetchSeats() async {
    try {
      final data = await ApiService.getSeats(widget.flightId);
      setState(() {
        seats = data.map<Seat>((seat) => Seat.fromJson(seat)).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching seats: $e");
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch seats')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Seat")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 seats per row
                childAspectRatio: 1.5, // Adjust the aspect ratio for seat size
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: seats.length,
              itemBuilder: (context, index) {
                final seat = seats[index];
                return SeatCard(
                  seat: seat,
                  onTap: () {
                    if (!seat.isBooked) {
                      // Handle seat selection
                      print("Seat ${seat.seatNumber} selected");
                    }
                  },
                );
              },
            ),
    );
  }
}