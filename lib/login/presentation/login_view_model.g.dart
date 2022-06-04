// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on _LoginViewModel, Store {
  late final _$stateAtom =
      Atom(name: '_LoginViewModel.state', context: context);

  @override
  ViewState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ViewState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$flowAtom = Atom(name: '_LoginViewModel.flow', context: context);

  @override
  LoginWidgetFlow get flow {
    _$flowAtom.reportRead();
    return super.flow;
  }

  @override
  set flow(LoginWidgetFlow value) {
    _$flowAtom.reportWrite(value, super.flow, () {
      super.flow = value;
    });
  }

  late final _$userAtom = Atom(name: '_LoginViewModel.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_LoginViewModel.status', context: context);

  @override
  StatusModel? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(StatusModel? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$otpQRAtom =
      Atom(name: '_LoginViewModel.otpQR', context: context);

  @override
  String? get otpQR {
    _$otpQRAtom.reportRead();
    return super.otpQR;
  }

  @override
  set otpQR(String? value) {
    _$otpQRAtom.reportWrite(value, super.otpQR, () {
      super.otpQR = value;
    });
  }

  late final _$loginAutomaticallyAtom =
      Atom(name: '_LoginViewModel.loginAutomatically', context: context);

  @override
  bool get loginAutomatically {
    _$loginAutomaticallyAtom.reportRead();
    return super.loginAutomatically;
  }

  @override
  set loginAutomatically(bool value) {
    _$loginAutomaticallyAtom.reportWrite(value, super.loginAutomatically, () {
      super.loginAutomatically = value;
    });
  }

  @override
  String toString() {
    return '''
state: ${state},
flow: ${flow},
user: ${user},
status: ${status},
otpQR: ${otpQR},
loginAutomatically: ${loginAutomatically}
    ''';
  }
}
