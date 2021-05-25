import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class SignupState extends Equatable {}

class SignupInitState extends SignupState {
  @override
  List<Object> get props => null;
}

class SignupLoadingState extends SignupState {
  @override
  List<Object> get props => null;
}

class SignupSuccessState extends SignupState {
  final User user;

  SignupSuccessState({@required this.user});

  @override
  List<Object> get props => null;
}

class SignupFailedState extends SignupState {
  final String msg;

  SignupFailedState({@required this.msg});

  @override
  List<Object> get props => null;
}
