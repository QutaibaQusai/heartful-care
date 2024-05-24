class Devices {
  String Id;
  final String deviceName;
  final String deviceBuyPrice;
  final String deviceRent;
  final String deviceDescription;
  final String deviceQuantity;
  final String deviceInstruction;
  final String supplierId;
  final List<String>deviceImages; 
  final String deviceId;

  Devices({
    required this.deviceImages,
    required this.deviceName,
    required this.deviceBuyPrice,
    required this.deviceRent,
    required this.deviceDescription,
    required this.deviceQuantity,
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
      deviceRent: map['devicePriceForRent'] ?? '',
      deviceDescription: map['deviceDescription'] ?? '',
      deviceQuantity: map['deviceQuantity'] ?? '',
      deviceInstruction: map['deviceInstruction'] ?? '',
      supplierId: map['supplierId'] ?? '',
      deviceId: map['DeviseId'] ?? '',
      deviceImages: images,
    );
  }
}
