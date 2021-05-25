import 'package:chat_app/bloc/signin_bloc/signin_event.dart';
import 'package:chat_app/bloc/signin_bloc/signin_state.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  UserRepository userRepository = UserRepository();

  SigninBloc(SigninState initialState) : super(initialState);

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is SigninSubmitEvent) {
      try {
        yield SigninLoadingState();
        User user = await userRepository.signinUser(
          event.email,
          event.password,
          event.context,
        );
        if (user == null) {
          yield SigninFailedState(msg: 'Something went wrong!');
        } else {
          yield SigninSuccessState(user: user);
        }
      } catch (e) {
        yield SigninFailedState(msg: e.toString());
      }
    } else if (event is SigninWithGoogleEvent) {
      yield SigninLoadingState();
      User user = await userRepository.googleAuthUser(event.context);
      yield SigninSuccessState(user: user);
    }
  }
}
