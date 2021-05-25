import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

abstract class SigninEvent extends Equatable {}

class SigninSubmitEvent extends SigninEvent {
  final String email, password;
  final BuildContext context;

  SigninSubmitEvent({
    @required this.email,
    @required this.password,
    @required this.context,
  });

  @override
  List<Object> get props => null;
}

class SigninWithGoogleEvent extends SigninEvent {
  final BuildContext context;

  SigninWithGoogleEvent(this.context);
  @override
  List<Object> get props => null;
}
