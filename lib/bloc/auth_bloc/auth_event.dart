import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class AppInitEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}
