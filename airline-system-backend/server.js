const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require("cors");
const bodyParser = require("body-parser");
const connectDB = require("./config/db");

// Load environment variables
dotenv.config();

// Import routes
const authRoutes = require("./routes/authRoutes");
const flightRoutes = require("./routes/flightRoutes");
const seatRoutes = require("./routes/seatRoutes");

// Initialize app
const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/flights", flightRoutes);
app.use("/api/seats", seatRoutes);

// MongoDB connection
const PORT = process.env.PORT || 5000;

connectDB() // Call the connectDB function
  .then(() => {
    app.listen(PORT, () =>
      console.log(`Server running on http://localhost:${PORT}`)
    );
  })
  .catch((err) => {
    console.error("Failed to connect to MongoDB. Exiting...");
    process.exit(1);
  });
