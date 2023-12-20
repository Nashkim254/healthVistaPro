part of 'reminder_cubit.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();
}

class ReminderInitial extends ReminderState {
  @override
  List<Object> get props => [];
}
class ReminderLoading extends ReminderState {
  @override
  List<Object> get props => [];
}
class ReminderLoaded extends ReminderState {
  List<Remind> reminders;
  ReminderLoaded(this.reminders);
  @override
  List<Object> get props => [reminders];
}

