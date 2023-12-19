part of 'vaccine_bloc.dart';

abstract class VaccineState extends Equatable {
  const VaccineState();
}

class VaccineInitial extends VaccineState {
  @override
  List<Object> get props => [];
}
class VaccineLoading extends VaccineState {
  @override
  List<Object> get props => [];
}
class VaccineLoaded extends VaccineState {
  List<Vaccine> vaccines;
  VaccineLoaded(this.vaccines);
  @override
  List<Object> get props => [vaccines];
}

