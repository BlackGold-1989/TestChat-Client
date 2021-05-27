class UserModel {
  int id;
  String fname;
  String email;

  UserModel({
    this.id = 0,
    this.fname = '',
    this.email = ''});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return new UserModel(
      id: map['id'] as int,
      fname: map['fname'] as String,
      email: map['email'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fname': this.fname,
      'email': this.email,
    };
  }
}