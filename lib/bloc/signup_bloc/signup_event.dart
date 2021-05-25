import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

abstract class SignupEvent extends Equatable {}

class SignupSubmitEvent extends SignupEvent {
  final String name, email, password;
  final BuildContext context;

  SignupSubmitEvent({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.context,
  });

  @override
  List<Object> get props => null;
}

class SignupWithGoogleEvent extends SignupEvent {
  final BuildContext context;

  SignupWithGoogleEvent(this.context);

  @override
  List<Object> get props => null;
}
