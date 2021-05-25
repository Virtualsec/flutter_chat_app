import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class SigninState extends Equatable {}

class SigninInitState extends SigninState {
  @override
  List<Object> get props => null;
}

class SigninLoadingState extends SigninState {
  @override
  List<Object> get props => null;
}

class SigninSuccessState extends SigninState {
  final User user;

  SigninSuccessState({@required this.user});

  @override
  List<Object> get props => null;
}

class SigninFailedState extends SigninState {
  final String msg;

  SigninFailedState({@required this.msg});

  @override
  List<Object> get props => null;
}
