const Flight = require('../models/Flight');
const { body, validationResult } = require('express-validator');
const mongoose = require('mongoose');

// Get all flights with optional pagination
const getFlights = async (req, res) => {
  const { page = 1, limit = 10 } = req.query;
  try {
    const flights = await Flight.find()
      .skip((page - 1) * limit)
      .limit(parseInt(limit));
    res.json(flights);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Get a single flight by ID
const getFlightById = async (req, res) => {
  const { id } = req.params;
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ message: "Invalid flight ID format" });
  }
  
  try {
    const flight = await Flight.findById(id);
    if (!flight) {
      return res.status(404).json({ message: "Flight not found" });
    }
    res.json(flight);
  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
};


// Get a single flight by flight number
const getFlightByFlightNumber = async (req, res) => {
  const { flightNumber } = req.params;
  try {
    const flight = await Flight.findOne({ flightNumber });
    if (!flight) {
      return res.status(404).json({ message: 'Flight not found' });
    }
    res.json(flight);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Add a new flight
const addFlight = async (req, res) => {
  const { flightNumber, origin, destination, departureTime, arrivalTime, seats, availableSeats } = req.body;

  try {
    const existingFlight = await Flight.findOne({ flightNumber });
    if (existingFlight) {
      return res.status(400).json({ message: 'Flight with this number already exists' });
    }

    const newFlight = new Flight({ flightNumber, origin, destination, departureTime, arrivalTime, seats, availableSeats });
    await newFlight.save();
    res.status(201).json(newFlight);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Update flight details
const updateFlight = async (req, res) => {
  const { id } = req.params;
  const { flightNumber, origin, destination, departureTime, arrivalTime, seats, availableSeats, status } = req.body;

  try {
    const flight = await Flight.findByIdAndUpdate(
      id, 
      { flightNumber, origin, destination, departureTime, arrivalTime, seats, availableSeats, status }, 
      { new: true }
    );

    if (!flight) {
      return res.status(404).json({ message: 'Flight not found' });
    }
    res.json(flight);
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

// Delete a flight
const deleteFlight = async (req, res) => {
  const { id } = req.params;
  try {
    const flight = await Flight.findByIdAndDelete(id);
    if (!flight) {
      return res.status(404).json({ message: 'Flight not found' });
    }
    res.json({ message: 'Flight deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};

module.exports = { 
  getFlights, 
  getFlightById, 
  getFlightByFlightNumber, 
  addFlight, 
  updateFlight, 
  deleteFlight
};
