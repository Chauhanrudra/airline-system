const express = require('express');
const { bookSeat, getSeatsForFlight } = require('../controllers/seatController');
const router = express.Router();

router.post('/book', bookSeat); // Book a seat on a flight
router.get('/:flightId', getSeatsForFlight); // Get all available seats for a specific flight

module.exports = router;
