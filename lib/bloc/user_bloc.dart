
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:health_vista_pro/models/models.dart';
import 'package:health_vista_pro/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // intial bloc v6
  UserBloc() : super(UserInitial()) {
    on<UserLoad>((event, emit) async {
      User user = await UserServices.getUser(event.id!);
      List<User> userList = await UserServices.getAllUser();
      emit(UserLoaded(user, userList));
    });
    on<UpdateUserData>((event, emit) async {
      User updatedUser = (state as UserLoaded).user!.copyWith(
          fullName: event.fullName,
          job: event.job,
          profileImage: event.profileImage,
          alumnus: event.alumnus,
          tempatPraktek: event.tempatPraktek);

      // update user in database
      await UserServices.updateUser(updatedUser);
      List<User> userList = await UserServices.getAllUser();
      emit(UserLoaded(updatedUser, userList));
    });

    on<UpdateUserState>((event, emit) async {
      User updateUser = (state as UserLoaded).user!.copyWith(state: event.state);
      await UserServices.updateUser(updateUser);
    });
    on<UserSignOut>((event, emit) => UserInitial());
  }
}
