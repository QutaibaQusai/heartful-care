class MedicalSupplier {
  final String name;
  final String phoneNumber;
  final String emailAddress;
  //final String LogoImage;
  //final String coverImage;
  final String website;
  final String location;
  final String description;
  final String paymentOption;
  MedicalSupplier(
      {required this.name,
      required this.phoneNumber,
      required this.emailAddress,
      required this.website,
      required this.description,
      required this.location,
      required this.paymentOption});

  factory MedicalSupplier.fromMap(Map<String, dynamic> map) {
    return MedicalSupplier(
      name: map['supplier_Name'] ?? '',
      phoneNumber: map['supplier_phoneNumber'] ?? '',
      emailAddress: map['supplier_email'] ?? '',
      website: map['supplier_website'] ?? '',
      location: map['supplier_location'] ?? '',
      description: map['supplier_description'] ?? '',
      paymentOption: map['supplier_paymnet_option'] ?? '',
    );
  }
}
