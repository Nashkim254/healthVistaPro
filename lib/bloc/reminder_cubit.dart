import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_vista_pro/models/models.dart';
import 'package:health_vista_pro/provider/providers.dart';
part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(ReminderInitial());
  Future getRemindersList() async {
    emit(ReminderLoading());
    List<Remind> reminders = await getReminder();
    emit(ReminderLoaded(reminders));
  }
}
