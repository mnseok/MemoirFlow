class Memoiral {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String date;
  final String location;
  final String userId;

  Memoiral({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.userId,
  });

  factory Memoiral.fromJson(Map<String, dynamic> json) {
    return Memoiral(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      date: json['date'],
      location: json['location'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'date': date,
      'location': location,
      'userId': userId,
    };
  }
}
