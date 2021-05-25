import 'dart:developer';

import 'package:chat_app/bloc/auth_bloc/auth_event.dart';
import 'package:chat_app/bloc/auth_bloc/auth_state.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository = UserRepository();

  AuthBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppInitEvent) {
      log('||----------App Init State----------||');
      try {
        var isSignin = await userRepository.isUserSignin();
        if (isSignin) {
          User user = await userRepository.getCurrentUser();
          yield AuthenticatedState(user: user);
        } else {
          yield UnAuthenticatedState();
        }
      } catch (e) {
        yield UnAuthenticatedState();
      }
    }
  }
}
