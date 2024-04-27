class Nurses {
  final String nurse_firstName;
  final String nurse_lastName;
  final String nurse_age;
  final String nurse_gender;
  final String nurse_phoneNumber;
  final String nurse_yearsExperience;
  final String nurse_qualifications;
  final String centerId;
  final String nurseSpecialization;

  Nurses(
      {required this.nurse_firstName,
      required this.nurse_lastName,
      required this.nurse_age,
      required this.nurse_gender,
      required this.nurse_phoneNumber,
      required this.nurse_yearsExperience,
      required this.nurse_qualifications,
      required this.centerId,
      required this.nurseSpecialization});

  factory Nurses.fromMap(Map<String, dynamic> map) {
    return Nurses(
      nurse_firstName: map['first_name'] ?? '',
      nurse_lastName: map['last_name'] ?? '',
      nurse_age: map['age'] ?? '',
      nurse_gender: map['gender'] ?? '',
      nurse_phoneNumber: map['phone_number'] ?? '',
      nurse_yearsExperience: map['years_experience'] ?? '',
      nurse_qualifications: map['qualifications'] ?? '',
      centerId: map['centerId'] ?? '',
      nurseSpecialization: map['nurseSpecialization'] ?? '',
    );
  }
}
