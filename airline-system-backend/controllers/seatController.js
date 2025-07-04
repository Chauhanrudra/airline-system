const Seat = require('../models/Seat');
const Flight = require('../models/Flight');

// Book a seat
const bookSeat = async (req, res) => {
  const { flightId, seatNumber } = req.body;
  try {
    const seat = await Seat.findOne({ flight: flightId, seatNumber });
    if (seat && seat.isBooked) {
      return res.status(400).json({ message: 'Seat already booked' });
    }

    // Update seat availability
    const updatedSeat = await Seat.findOneAndUpdate(
      { flight: flightId, seatNumber },
      { isBooked: true },
      { new: true, upsert: true }
    );

    // Decrement available seats in the flight
    await Flight.findByIdAndUpdate(flightId, { $inc: { availableSeats: -1 } });

    res.json(updatedSeat);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Get all seats for a flight
const getSeatsForFlight = async (req, res) => {
  const { flightId } = req.params;
  try {
    const seats = await Seat.find({ flight: flightId });
    res.json(seats);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

module.exports = { bookSeat, getSeatsForFlight };
