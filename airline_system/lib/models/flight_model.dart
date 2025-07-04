class Flight {
  final String id;
  final String flightNumber;
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final int seats;
  final int availableSeats;
  final String status;

  Flight({
    required this.id,
    required this.flightNumber,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.seats,
    required this.availableSeats,
    required this.status,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['_id'],
      flightNumber: json['flightNumber'],
      origin: json['origin'],
      destination: json['destination'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      seats: json['seats'],
      availableSeats: json['availableSeats'],
      status: json['status'],
    );
  }
}
