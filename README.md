# Airline Reservation & Management System

A complete full-stack mobile and backend application for managing airline flights, reservations, and bookings.

## 📱 Frontend (Flutter)
- Developed using **Flutter** framework.
- User authentication with **JWT Token**.
- Role-based dashboard for **Passengers** and **Officers**.
- Features:
  - Login / Register screens
  - View flights list
  - Officer dashboard to Add / Update / Delete flights

## 🖥️ Backend (Node.js, Express, MongoDB)
- Built RESTful APIs using **Express.js**.
- Database: **MongoDB**.
- JWT-based Authentication.
- Role-based authorization middleware.

## 📦 Tech Stack
- Flutter (Dart)
- Node.js
- Express.js
- MongoDB
- SharedPreferences (for local storage)
- JWT Authentication

## 🔐 Environment Variables
Create a `.env` file for your backend with:

```
PORT=5000
MONGO_URI=your connection string 
JWT_SECRET=your secret 
```

## 🚀 Run Instructions

**Backend:**
```bash
cd backend
npm install
npm run dev
```

**Frontend:**
```bash
cd frontend
flutter pub get
flutter run
```

## 📖 Description
A full-stack airline system to manage flights and reservations with secure authentication, officer-specific controls, and dynamic flight/seat management APIs.
