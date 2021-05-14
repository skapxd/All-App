import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/phone.dart';

part 'phone_event.dart';
part 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc()
      : super(
          PhoneState(
            modelPhone: ModelPhone(
              msg: '',
              phone: '',
              token: '',
            ),
          ),
        );

  @override
  Stream<PhoneState> mapEventToState(
    PhoneEvent event,
  ) async* {
    if (event is AddPhone) {
      //
      yield PhoneState(
        modelPhone: state.modelPhone.copyWith(phone: event.phone),
      );
      //
    } else if (event is AddMsg) {
      //
      yield PhoneState(
        modelPhone: state.modelPhone.copyWith(msg: event.msg),
      );
      //
    } else if (event is AddToken) {
      //
      yield PhoneState(
        modelPhone: state.modelPhone.copyWith(token: event.token),
      );
      //
    }
  }
}
