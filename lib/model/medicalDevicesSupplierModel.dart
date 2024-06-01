class MedicalSupplier {
  
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String logoImage;
  final String website;
  final String location;
  final String description;
  final String paymentOption;
  final String supplierCover;
  final String supplierId;

  MedicalSupplier({
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.website,
    required this.description,
    required this.location,
    required this.paymentOption,
    required this.logoImage,
    required this.supplierCover,
    required this.supplierId,
  });

  factory MedicalSupplier.fromMap(Map<String, dynamic> map) {
    return MedicalSupplier(
      name: map['supplier_Name'] ?? 'Not Found',
      phoneNumber: map['supplier_phoneNumber'] ?? 'Not Found',
      emailAddress: map['supplier_email'] ?? 'Not Found',
      website: map['supplier_website'] ?? 'Not Found',
      location: map['supplier_location'] ?? 'Not Found',
      description: map['supplier_description'] ?? 'Not Found',
      paymentOption: map['supplier_paymnet_option'] ?? '',
      logoImage: map['supplier_profile'] ??
          'https://thinksport.com.au/wp-content/uploads/2020/01/avatar-.jpg',
      supplierCover: map['supplier_cover'] ??
          'https://thinksport.com.au/wp-content/uploads/2020/01/avatar-.jpg',
      supplierId: map['supplier_id'] ?? 'Not Found',
    );
  }
}
