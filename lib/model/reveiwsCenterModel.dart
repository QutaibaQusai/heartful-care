import 'package:intl/intl.dart';

class Reviews_Center {
  final DateTime date; // Store date as DateTime object
  final String userName;
  final String reviews;
  final double rating;

  Reviews_Center({
    required this.date,
    this.userName = '',
    this.reviews = '',
    this.rating = 0.0,
  });

  factory Reviews_Center.fromMap(Map<String, dynamic> map) {
    // Parse the date string into a DateTime object
    DateTime parsedDate =
        DateTime.parse(map['date']?.toString() ?? DateTime.now().toString());

    return Reviews_Center(
      date: parsedDate,
      userName: map['userName'] ?? '',
      reviews: map['reviewText'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }

  // Method to format date as a string
  String formattedDate() {
    return DateFormat('d/MMM/yyyy').format(date);
  }
}
