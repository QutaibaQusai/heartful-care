class Devices {
  //final String deviceImages;
  final String deviceName;
  final String devicePrice;
  final String deviceRent;
  final String deviceDescription;
  final String deviceQuantity;
  final String deviceInstruction;
  final String supplierId;

  Devices(
      {required this.deviceName,
      required this.devicePrice,
      required this.deviceRent,
      required this.deviceDescription,
      required this.deviceQuantity,
      required this.deviceInstruction,
      required this.supplierId});
  factory Devices.fromMap(Map<String, dynamic> map) {
    return Devices(
      deviceName: map['Device_Name'] ?? '',
      devicePrice: map['devicePriceForPuy'] ?? '',
      deviceRent: map['devicePriceForRent'] ?? '',
      deviceDescription: map['deviceDescription'] ?? '',
      deviceQuantity: map['deviceQuantity'] ?? '',
      deviceInstruction: map['deviceInstruction'] ?? '',
      supplierId: map['supplierId'] ?? '',
    );
  }
}
