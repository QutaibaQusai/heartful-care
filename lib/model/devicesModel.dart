class Devices {
  String Id;
  final String deviceName;
  final String deviceBuyPrice;
  final String deviceRentPrice;
  final String deviceDescription;
  final bool deviceAavailability;
  final String deviceInstruction;
  final String supplierId;
  final List<String> deviceImages;
  final String deviceId;

  Devices({
    required this.deviceImages,
    required this.deviceName,
    required this.deviceBuyPrice,
    required this.deviceRentPrice,
    required this.deviceDescription,
    required this.deviceAavailability,
    required this.Id,
    required this.deviceInstruction,
    required this.supplierId,
    required this.deviceId,
  });

  factory Devices.fromMap(String Id, Map<String, dynamic> map) {
    List<String> images = [];
    if (map['ImageUrls'] != null) {
      images = List<String>.from(map['ImageUrls']);
    }

    return Devices(
      Id: Id,
      deviceName: map['Device_Name'] ?? '',
      deviceBuyPrice: map['devicePriceForPuy'] ?? '',
      deviceRentPrice: map['devicePriceForRent'] ?? '',
      deviceDescription: map['deviceDescription'] ?? '',
      deviceAavailability: map['Device_availability'] ?? '',
      deviceInstruction: map['deviceInstructions'] ?? '',
      supplierId: map['supplierId'] ?? '',
      deviceId: map['DeviseId'] ?? '',
      deviceImages: images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Device_Name': deviceName,
      'devicePriceForPuy': deviceBuyPrice,
      'devicePriceForRent': deviceRentPrice,
      'deviceDescription': deviceDescription,
      'Device_availability': deviceAavailability,
      'deviceInstructions': deviceInstruction,
      'supplierId': supplierId,
      'DeviseId': deviceId,
      'ImageUrls': deviceImages,
    };
  }
}
