const express = require('express');
const { getFlights, getFlightById, getFlightByFlightNumber, addFlight, updateFlight, deleteFlight } = require('../controllers/flightController');
const { protect, officerOnly } = require('../middleware/authMiddleware');
const { flightValidationRules } = require('../controllers/flightController'); // Import validation rules

const router = express.Router();

// Public Routes
router.get('/', getFlights); // View all flights
router.get('/search/:flightNumber', getFlightByFlightNumber); // Search flight by flight number
router.get('/:id', getFlightById); // View a single flight by ID

// Admin Routes (Officers Only)
router.post('/', protect, officerOnly, addFlight); // Add a flight with validation
router.put('/:id', protect, officerOnly, updateFlight); // Update a flight with validation
router.delete('/:id', protect, officerOnly, deleteFlight); // Delete a flight

module.exports = router;
