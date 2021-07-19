class ModelPhone {
  final String phone;
  final String msg;
  final String token;
  final String code;

  ModelPhone({
    this.phone,
    this.msg,
    this.token,
    this.code,
  });

  ModelPhone copyWith({
    String phone,
    String msg,
    String token,
    String code,
  }) =>
      ModelPhone(
        phone: phone ?? this.phone,
        msg: msg ?? this.msg,
        token: token ?? this.token,
        code: code ?? this.code,
      );
}
