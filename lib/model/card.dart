class UsersCards {
  final String cardNumber;
  final String cardExpiryDate;
  final String cardCvv;

  UsersCards(
      {required this.cardNumber,
      required this.cardExpiryDate,
      required this.cardCvv});

  factory UsersCards.fromMap(Map<String, dynamic> map) {
    return UsersCards(
      cardNumber: map['cardNumber'] ?? '',
      cardExpiryDate: map['cardNumber'] ?? '',
      cardCvv: map['cvv'] ?? '',
    );
  }
}
