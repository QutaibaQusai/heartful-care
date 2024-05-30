class UserInfo {
  String Id;
  final String userImage;
  final String userName;
  final String phoneNumber;
  final String dateOfBirth;
  final String nationalId;
  final String gender;
  final String area;
  final String addressNickname;
  final String street;
  final String building;
  final String floor;
  final String appartment;

  UserInfo({
    required this.Id,
    required this.userImage,
    required this.userName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.nationalId,
    required this.gender,
    required this.area,
    required this.addressNickname,
    required this.street,
    required this.building,
    required this.floor,
    required this.appartment,
  });
  factory UserInfo.fromMap(String Id, Map<String, dynamic> map) {
    return UserInfo(
      Id: Id,
      userImage: map['users_profile'] ?? '',
      userName: map['fullname'] ?? '',
      phoneNumber: map['Phone Number'] ?? '',
      dateOfBirth: map['DateOfBirth'] ?? '',
      nationalId: map['NationalID'] ?? '',
      gender: map['Gender'] ?? '',
      area: map["Area"] ?? '',
      addressNickname: map['Address nickname'] ?? '',
      street: map['Street'] ?? '',
      building: map['Building'] ?? '',
      floor: map['Floor'] ?? '',
      appartment: map['apartment'] ?? '',
    );
  }
}
