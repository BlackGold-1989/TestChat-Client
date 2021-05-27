class MessageModel {
  int id;
  String userid;
  String msg;
  String regdate;

  MessageModel({
    this.id = 0,
    this.userid = '',
    this.msg = '',
    this.regdate = ''});

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return new MessageModel(
      id: map['id'] as int,
      userid: map['userid'] as String,
      msg: map['msg'] as String,
      regdate: map['regdate'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userid': this.userid,
      'msg': this.msg,
      'regdate': this.regdate,
    };
  }
}