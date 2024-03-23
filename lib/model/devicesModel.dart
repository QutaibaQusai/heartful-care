class Devices {
  final String deviceName;
  final String devicePrice;
  final String deviceRent;
  final String deviceDescription;
  final String deviceQuantity;
  final String deviceInstruction;
  final String supplierId;
  final String deviceImage1;
  final String deviceImage2;
  final String deviceImage3;
  final String deviceId;

  Devices({
    required this.deviceName,
    required this.devicePrice,
    required this.deviceRent,
    required this.deviceDescription,
    required this.deviceQuantity,
    required this.deviceInstruction,
    required this.supplierId,
    required this.deviceImage1,
    required this.deviceImage2,
    required this.deviceImage3,
    required this.deviceId,
  });
  factory Devices.fromMap(Map<String, dynamic> map) {
    return Devices(
      deviceName: map['Device_Name'] ?? '',
      devicePrice: map['devicePriceForPuy'] ?? '',
      deviceRent: map['devicePriceForRent'] ?? '',
      deviceDescription: map['deviceDescription'] ?? '',
      deviceQuantity: map['deviceQuantity'] ?? '',
      deviceInstruction: map['deviceInstruction'] ?? '',
      supplierId: map['supplierId'] ?? '',
      deviceImage1: map['DeviceImages_1'] ?? '',
      deviceImage2: map['DeviceImages_2'] ?? '',
      deviceImage3: map['DeviceImages_3'] ?? '',
      deviceId: map['DeviseId'] ?? '',
    );
  }
}
