part of 'phone_bloc.dart';

@immutable
abstract class PhoneEvent {}

class AddPhone extends PhoneEvent {
  final String phone;

  AddPhone(this.phone);
}

class AddCountryCode extends PhoneEvent {
  final String code;

  AddCountryCode(this.code);
}

class AddMsg extends PhoneEvent {
  final String msg;

  AddMsg(this.msg);
}

class AddToken extends PhoneEvent {
  final String token;

  AddToken(this.token);
}
