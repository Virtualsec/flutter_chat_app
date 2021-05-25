import 'package:chat_app/bloc/signup_bloc/signup_event.dart';
import 'package:chat_app/bloc/signup_bloc/signup_state.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserRepository userRepository = UserRepository();

  SignupBloc(SignupState initialState) : super(initialState);

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupSubmitEvent) {
      try {
        yield SignupLoadingState();
        User user = await userRepository.signupUser(
          event.name,
          event.email,
          event.password,
          event.context,
        );
        if (user == null) {
          yield SignupFailedState(msg: 'Something went wrong!');
        } else {
          yield SignupSuccessState(user: user);
        }
      } catch (e) {
        yield SignupFailedState(msg: e.toString());
      }
    } else if (event is SignupWithGoogleEvent) {
      yield SignupLoadingState();
      User user = await userRepository.googleAuthUser(event.context);
      yield SignupSuccessState(user: user);
    }
  }
}
