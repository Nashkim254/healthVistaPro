part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnWelcomePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  final int bottomNavBarindex;

  const OnMainPage({this.bottomNavBarindex = 0});
  @override
  List<Object> get props => [bottomNavBarindex];
}

class OnRegistrationPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnRegistrationUserPage extends PageState {
  final RegistrationUserData registrationUserData;
  const OnRegistrationUserPage(this.registrationUserData);

  @override
  List<Object> get props => [];
}

class OnRegistrationDoctorPage extends PageState {
  final RegistrationUserData registrationUserData;
  const OnRegistrationDoctorPage(this.registrationUserData);

  @override
  List<Object> get props => [];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationUserData registrationUserData;
  const OnAccountConfirmationPage(this.registrationUserData);

  @override
  List<Object> get props => [];
}

class OnUserProfilePage extends PageState {
  @override
  List<Object> get props => [];
}
class OnBookAppointmentPage extends PageState {
   final User patient;
   final User doctor;
  const OnBookAppointmentPage(this.patient, this.doctor);
  @override
  List<Object> get props => [patient, doctor];
}
class OnMyAppointments extends PageState {
  @override
  List<Object> get props => [];
}

class OnUserProfilePageMenu extends PageState {
  @override
  List<Object> get props => [];
}

class OnEditProfilePage extends PageState {
  final User user;

  const OnEditProfilePage(this.user);
  @override
  List<Object> get props => [user];
}

class OnDoctorSelectedPage extends PageState {
  final DoctorType doctorType;
  const OnDoctorSelectedPage(this.doctorType);
  @override
  List<Object> get props => [doctorType];
}

class OnChatScreenPage extends PageState {
  final User receiver;
  final User sender;
  const OnChatScreenPage(this.receiver, this.sender);

  @override
  List<Object> get props => [receiver, sender];
}

class OnCallScreenPage extends PageState {
  final Call call;
  final User sender;
  final User receiver;
  const OnCallScreenPage(this.call, this.sender, this.receiver);
  @override
  List<Object> get props => [call, sender, receiver];
}

class OnChatListScreenPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSeeDoctorPage extends PageState {
  final User user;
  const OnSeeDoctorPage(this.user);
  @override
  List<Object> get props => [user];
}

class OnHistoryPatientPage extends PageState {
  final Call call;
  const OnHistoryPatientPage(this.call);
  @override
  List<Object> get props => [call];
}

class OnDoctorRatingPage extends PageState {
  final Call call;
  const OnDoctorRatingPage(this.call);
  @override
  List<Object> get props => [call];
}

class OnPatientListMedicalRecordPage extends PageState {
  final User user;
  const OnPatientListMedicalRecordPage(this.user);
  @override
  List<Object> get props => [user];
}
