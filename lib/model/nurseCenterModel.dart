class NurseCenter {
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String urlLogoImage;
  final String addressOne;
  final String addressTwo;
  final String operatingHours;
  final String contactName;
  final String contactPosition;
  final String description;
  final String website;

  NurseCenter({
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.urlLogoImage,
    required this.addressOne,
    required this.addressTwo,
    required this.operatingHours,
    required this.contactName,
    required this.contactPosition,
    required this.description,
    required this.website,
  });

  factory NurseCenter.fromMap(Map<String, dynamic> map) {
    return NurseCenter(
      name: map['Center Name'] ?? '',
      phoneNumber: map['Center phone number'] ?? '',
      emailAddress: map['Center Email Address'] ?? '',
      urlLogoImage: map['URL Logo Image'] ??
          'https://img.freepik.com/premium-vector/home-care-logo_590037-186.jpg',
      addressOne: map['Center Address 1'] ?? '',
      addressTwo: map['Center Address 2'] ?? '',
      operatingHours: map['Center operating Hours'] ?? '',
      contactName: map['Contact Center name'] ?? '',
      contactPosition: map['Contact Center position'] ?? '',
      description: map['Contact Description'] ?? '',
      website: map['Contact website'] ?? '',
    );
  }
}
