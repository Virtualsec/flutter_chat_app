import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class LogoutEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}
