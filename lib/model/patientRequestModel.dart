class Patient_request {
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String phoneNumber;
  final String address;
  final bool allergies;
  final bool surgeriesHistory;
  final bool isWalk;
  final List needNurse;
  final String centerId;
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
      required this.centerId});

  factory Patient_request.fromMap(Map<String, dynamic> map) {
    return Patient_request(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      allergies: map['hasAllergies'] ?? '',
      surgeriesHistory: map['historyOfSurgeries'] ?? '',
      isWalk: map['isWalk'] ?? '',
      needNurse: map['needNurse'] ?? '',
      centerId: map['center_id'] ?? '',
    );
  }
}
