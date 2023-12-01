import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_vista_pro/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  // intial bloc v6
  PageBloc() : super(OnWelcomePage()) {
    on<GoToWelcomePage>((event, emit) =>emit(OnWelcomePage()));
    on<GoToLoginPage>((event, emit) => emit(OnLoginPage()));
    on<GoToMainPage>((event, emit) => emit( OnMainPage(bottomNavBarindex: event.bottomNavBarIndex)));
    on<GoToRegistrationPage>((event, emit) => emit(OnRegistrationPage()));
    on<GoToRegistrationUserPage>((event, emit) => emit(OnRegistrationUserPage(event.registrationUserData)));
    on<GoToRegistrationDoctorPage>((event, emit) => emit(OnRegistrationDoctorPage(event.registrationUserData)));
    on<GoToConfirmationPage>((event, emit) => emit(OnAccountConfirmationPage(event.registrationUserData)));
    on<GoToUserProfilePage>((event, emit) => emit(OnUserProfilePage()));
    on<GoToEditProfilePage>((event, emit) => emit(OnEditProfilePage(event.user)));
    on<GoToDoctorSelectedPage>((event, emit) => emit(OnDoctorSelectedPage(event.doctorType)));
    on<GoToChatScreenPage>((event, emit) => emit(OnChatScreenPage(event.receiver!, event.sender!)));
    on<GoToCallScreenPage>((event, emit) => emit( OnCallScreenPage(event.call!, event.sender!, event.receiver!)));
    on<GoToChatListScreenPage>((event, emit) => emit(OnChatListScreenPage()));
    on<GoToUserProfilePageMenu>((event, emit) => emit(OnUserProfilePageMenu()));
    on<GoToSeeDoctorPage>((event, emit) => emit(OnSeeDoctorPage(event.user)));
    on<GoToHistoryPatientPage>((event, emit) => emit(OnHistoryPatientPage(event.call)));
    on<GoToDoctorRatingPage>((event, emit) => emit(OnDoctorRatingPage(event.call)));
    on<GoToPatientListMedicalRecordPage>((event, emit) => emit(OnPatientListMedicalRecordPage(event.user)));
  }
}
