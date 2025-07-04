class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? password; // Optional, only needed if used in signup

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.password, // Nullable
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "role": role,
      if (password != null) "password": password, // Include only if present
    };
  }
}
