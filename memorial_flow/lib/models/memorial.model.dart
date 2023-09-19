class Memoiral {
  final String id;
  final String content;
  // final String imageUrl;
  final int timeType;
  // final String location;
  final String userId;

  Memoiral({
    required this.id,
    required this.content,
    // required this.imageUrl,
    required this.timeType,
    // required this.location,
    required this.userId,
  });

  factory Memoiral.fromJson(Map<String, dynamic> json) {
    return Memoiral(
      id: json['id'],
      content: json['content'],
      // imageUrl: json['imageUrl'],
      timeType: json['timeType'],
      // location: json['location'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      // 'imageUrl': imageUrl,
      'timeType': timeType,
      // 'location': location,
      'userId': userId,
    };
  }
}
