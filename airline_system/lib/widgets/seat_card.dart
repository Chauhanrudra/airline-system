import 'package:flutter/material.dart';
import '../models/seat_model.dart';

class SeatCard extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;

  SeatCard({required this.seat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: seat.isBooked ? Colors.grey : Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            seat.seatNumber,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}