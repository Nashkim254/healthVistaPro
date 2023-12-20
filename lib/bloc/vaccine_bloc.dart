import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';
import '../provider/providers.dart';

part 'vaccine_state.dart';

class VaccineCubit extends Cubit<VaccineState> {
  VaccineCubit() : super(VaccineInitial());

  Future<void> markAsCompleted(Vaccine vaccine) async {
    emit(VaccineLoading());
    await DbHelper.markVaccineAsCompleted(vaccine);
    getVaccines();
    emit(VaccineLoaded(vaccines));
  }
  Future getVaccines() async {
    emit(VaccineLoading());
    List<Vaccine> vaccines = await DbHelper.getImmunizations();
    emit(VaccineLoaded(vaccines));
    return vaccines;
  }
  Future addVaccine(Vaccine vaccine) async {
    emit(VaccineLoading());
   await DbHelper.insertImmunization(vaccine);
    getVaccines();
    emit(VaccineLoaded(vaccines));
    return vaccines;
  }
}
