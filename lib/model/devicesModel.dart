class Devices {
  final String deviceName;
  final String devicePrice;
  final String deviceRent;
  final String deviceDescription;
  final String deviceQuantity;
  final String deviceInstruction;
  final String supplierId;
  final List<String> deviceImages; // Now a list to hold multiple image URLs

  final String deviceId;

  Devices( {required this.deviceImages,
    required this.deviceName,
    required this.devicePrice,
    required this.deviceRent,
    required this.deviceDescription,
    required this.deviceQuantity,
    required this.deviceInstruction,
    required this.supplierId,
   
    required this.deviceId,
  });
  factory Devices.fromMap(Map<String, dynamic> map) {
     // Attempt to extract image URLs from the map
    // Assuming the images are stored in a list format under a key in the map
    List<String> images = [];
    if (map['ImageUrls'] != null) {
      images = List<String>.from(map['ImageUrls']);
    }

    return Devices(
      deviceName: map['Device_Name'] ?? '',
      devicePrice: map['devicePriceForPuy'] ?? '',
      deviceRent: map['devicePriceForRent'] ?? '',
      deviceDescription: map['deviceDescription'] ?? '',
      deviceQuantity: map['deviceQuantity'] ?? '',
      deviceInstruction: map['deviceInstruction'] ?? '',
      supplierId: map['supplierId'] ?? '',
     
      deviceId: map['DeviseId'] ?? '', deviceImages: images,
    );
  }
}
