const mongoose = require('mongoose');

const seatSchema = new mongoose.Schema({
  flight: { type: mongoose.Schema.Types.ObjectId, ref: 'Flight', required: true },
  seatNumber: { type: String, required: true },
  isBooked: { type: Boolean, default: false },
});

module.exports = mongoose.model('Seat', seatSchema);
