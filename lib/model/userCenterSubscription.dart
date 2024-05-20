
class UserCenterSubscription {
  final String centerId;
  final String userId;
  final String userEmail;
  final String startDate;
  final String endDate;
  final int subscriptionStatus;
  final String paymentMethod;

  UserCenterSubscription({
    required this.centerId,
    required this.userId,
    required this.userEmail,
    required this.startDate,
    required this.endDate,
    required this.subscriptionStatus,
    required this.paymentMethod,
  });

  
  factory UserCenterSubscription.fromMap(Map<String, dynamic> map) {
    return UserCenterSubscription(
      centerId: map['centerId'] ?? '',
      userId: map['userId'] ?? '',
      userEmail: map['userEmail'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      subscriptionStatus: map['subscriptionStatus'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
    );
  }
}
