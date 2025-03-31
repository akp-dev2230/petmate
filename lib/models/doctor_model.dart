class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final String experience;
  final double rating;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.experience,
    required this.rating,
  });

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      specialty: map['specialty'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      experience: map['experience'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'imageUrl': imageUrl,
      'experience': experience,
      'rating': rating,
    };
  }
} 