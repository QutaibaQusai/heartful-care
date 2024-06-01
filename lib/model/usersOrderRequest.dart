import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceRequest {
  final String id;
  final String supplierId;
  final String userName;
  final String userImage;
  final String userEmail;
  final Timestamp userOrderTimeAndDate;
  final String userArea;
  final String userStreet;
  final int orderStatus;

  DeviceRequest({
    required this.id,
    required this.supplierId,
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.userOrderTimeAndDate,
    required this.userArea,
    required this.userStreet,
    required this.orderStatus,
  });

  factory DeviceRequest.fromMap(String id, Map<String, dynamic> map) {
    return DeviceRequest(
        id: id,
        supplierId: map['supplierId'] ?? '',
        userName: map['firstName'] ?? '',
        userImage: map['userImage'] ?? '',
        userEmail: map['userEmail'] ?? '',
        userOrderTimeAndDate: map['timestamp'] ?? Timestamp.now(),
        userArea: map['area'] ?? '',
        userStreet: map['street'] ?? '',
        orderStatus: map['orderStatus']);
  }
}
