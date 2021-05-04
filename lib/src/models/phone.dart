class ModelPhone {
  final String phone;
  final String msg;
  final String token;

  ModelPhone({this.phone, this.msg, this.token});

  ModelPhone copyWith({
    String phone,
    String msg,
    String token,
  }) =>
      ModelPhone(
        phone: phone ?? this.phone,
        msg: msg ?? this.msg,
        token: token ?? this.token,
      );
}
