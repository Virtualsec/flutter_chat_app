import 'package:chat_app/bloc/home_bloc/home_event.dart';
import 'package:chat_app/bloc/home_bloc/home_state.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  UserRepository userRepository = UserRepository();

  HomeBloc(HomeState initialState) : super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LogoutEvent) {
      await userRepository.signoutUser();
      yield LogoutSuccessState();
    }
  }
}
