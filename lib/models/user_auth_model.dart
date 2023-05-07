class UserAuthModel {
  String? id;
  String? name;
  String? mobileNo;
  String? email;
  UserAuthModel({this.id, this.name, this.mobileNo, this.email});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobileNo': mobileNo,
      'email': email,
    };
  }

  static UserAuthModel fromJson(Map<String, dynamic> map) {
    return UserAuthModel(
        id: map['id'],
        name: map['name'],
        mobileNo: map['mobileNo'],
        email: map['email']);
  }
}
