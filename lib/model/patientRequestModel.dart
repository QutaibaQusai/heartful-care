class Patient_request {
  final String firstName;
  final String lastName;
  final String age;
  final String gender;
  final String phoneNumber;
  final String address;
  final bool allergies;
  final bool surgeriesHistory;
  final bool isWalk;
  final List needNurse;
  final String centerId;
  final double total_amount;
  final String payment_method;
  final int status;
  final String formRequestId;

  Patient_request(
      {required this.age,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.phoneNumber,
      required this.address,
      required this.allergies,
      required this.surgeriesHistory,
      required this.isWalk,
      required this.needNurse,
      required this.centerId,
      required this.total_amount,
      required this.payment_method,
      required this.status,
      required this.formRequestId});

  factory Patient_request.fromMap(Map<String, dynamic> map) {
    return Patient_request(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      allergies: map['hasAllergies'] ?? false,
      surgeriesHistory: map['historyOfSurgeries'] ?? false,
      isWalk: map['isWalk'] ?? false,
      needNurse: List<String>.from(map['needNurse'] ?? []),
      centerId: map['center_id'] ?? '',
      total_amount: map['total_amount'] ?? '',
      payment_method: map['payment_method'],
      status: map['status'],
      formRequestId: map['form_request_id'] ?? "",
    );
  }
}
