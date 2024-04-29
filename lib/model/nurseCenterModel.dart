class NurseCenter {
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String addressOne;
  final String addressTwo;
  final String operatingHours;
  final String operatingDays;
  final String checkup;
  final String pricePreDay;
  final String contactName;
  final String contactPosition;
  final String description;
  final String website;
  final String centerLocation;
  final String pricePreMonth;
  final String pricePerthreeMonths;
  final String pricePersixMonths;
  final String centerProfileImage;

  NurseCenter({
    required this.pricePersixMonths,
    required this.pricePerthreeMonths,
    required this.pricePreMonth,
    required this.pricePreDay,
    required this.centerLocation,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.addressOne,
    required this.addressTwo,
    required this.operatingHours,
    required this.operatingDays,
    required this.contactName,
    required this.contactPosition,
    required this.description,
    required this.website,
    required this.checkup,
    required this.centerProfileImage,
  });

  factory NurseCenter.fromMap(Map<String, dynamic> map) {
    return NurseCenter(
      name: map['Center Name'] ?? '',
      phoneNumber: map['Center phone number'] ?? '',
      emailAddress: map['Email'] ?? '',
      addressOne: map['Center Address 1'] ?? '',
      addressTwo: map['Center Address 2'] ?? '',
      operatingHours: map['Center operating Hours'] ?? '',
      operatingDays: map['Center operating Days'] ?? '',
      contactName: map['Contact Center name'] ?? '',
      contactPosition: map['Contact Center position'] ?? '',
      description: map['Center Description'] ?? '',
      website: map['Center website'] ?? '',
      centerLocation: map['Center location'] ?? '',
      pricePreDay: map['Price Per Day'] ?? '',
      pricePreMonth: map['Price Per one Month'] ?? '',
      pricePersixMonths: map['Price Per six Months'] ?? '',
      pricePerthreeMonths: map['Price Per three Months'] ?? '',
      checkup: map['Price_checkup'] ?? '',
      centerProfileImage: map['centerProfileImage'] ?? '',
    );
  }
}
