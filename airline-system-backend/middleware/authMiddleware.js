const jwt = require('jsonwebtoken');
const User = require('../models/user');

// Middleware to protect routes
const protect = async (req, res, next) => {
  let token;

  if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
    try {
      token = req.headers.authorization.split(' ')[1];

      // Decode the token
      const decoded = jwt.verify(token, process.env.JWT_SECRET);

      req.user = await User.findById(decoded.id).select('-password');
      next();
    } catch (err) {
      res.status(401).json({ message: 'Not authorized, token failed' });
    }
  }

  if (!token) {
    res.status(401).json({ message: 'Not authorized, no token' });
  }
};

// Middleware to allow only officers
const officerOnly = (req, res, next) => {
  if (req.user && req.user.role === 'officer') {
    next();
  } else {
    res.status(403).json({ message: 'Access denied, officer only' });
  }
};

module.exports = { protect, officerOnly };
