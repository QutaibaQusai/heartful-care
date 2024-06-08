import 'package:intl/intl.dart';

class Reviews_Supplier {
  String Id;
  final DateTime date;
  final String userName;
  final String reviews;
  final double rating;
  final String userImage;

  Reviews_Supplier(
      {required this.date,
      this.userName = '',
      this.reviews = '',
      this.rating = 0.0,
      required this.Id,
      required this.userImage});

  factory Reviews_Supplier.fromMap(String Id, Map<String, dynamic> map) {
    // Parse the date string into a DateTime object
    DateTime parsedDate =
        DateTime.parse(map['date']?.toString() ?? DateTime.now().toString());

    return Reviews_Supplier(
      Id: Id,
      date: parsedDate,
      userName: map['userName'] ?? '',
      reviews: map['reviewText'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      userImage: map['userImage'] ?? '',
    );
  }

  // Method to format date as a string
  String formattedDate() {
    return DateFormat('d/MMM/yyyy').format(date);
  }
}
