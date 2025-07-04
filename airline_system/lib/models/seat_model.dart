class Seat {
  final String id;
  final String flightId;
  final String seatNumber;
  final bool isBooked;

  Seat({
    required this.id,
    required this.flightId,
    required this.seatNumber,
    required this.isBooked,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['_id'],
      flightId: json['flight'],
      seatNumber: json['seatNumber'],
      isBooked: json['isBooked'],
    );
  }
}
