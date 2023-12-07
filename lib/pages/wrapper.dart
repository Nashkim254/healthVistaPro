part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get firebase user current status
    User? firebaseUser = Provider.of<User?>(context);

    // check user login status
    // if user not login
    if (firebaseUser == null) {
      prevPageEvent = GoToWelcomePage();
      context.read<PageBloc>().add(prevPageEvent!);
      prevPageEvent = GoToWelcomePage();
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        //before go to main page, load user from firebase
        context.read<UserBloc>().add(UserLoad(id: firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.read<PageBloc>().add(prevPageEvent!);
      }
    }

    // if there's change
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) => (state is OnWelcomePage)
          ? WelcomePage()
          : (state is OnLoginPage)
              ? LoginPage()
              : (state is OnRegistrationPage)
                  ? RegistrationPage()
                  : (state is OnRegistrationUserPage)
                      ? UserRegistrationPage(state.registrationUserData)
                      : (state is OnRegistrationDoctorPage)
                          ? DoctorRegistrationPage(state.registrationUserData)
                          : (state is OnAccountConfirmationPage)
                              ? AccountConfirmationPage(state.registrationUserData)
                              : (state is OnUserProfilePage)
                                  ? UserProfilePage()
                                  : (state is OnUserProfilePageMenu)
                                      ? UserProfilePageMenu()
                                      : (state is OnEditProfilePage)
                                          ? EditProfilePage(state.user)
                                          : (state is OnDoctorSelectedPage)
                                              ? DoctorSelectedPageList(state.doctorType)
                                              : (state is OnChatScreenPage)
                                                  ? ChatScreenPage(
                                                      receiver: state.receiver,
                                                      sender: state.sender,
                                                    )
                                                  // : (state is OnCallScreenPage)
                                                  //     ? CallScreen(
                                                  //         call: state.call,
                                                  //         user: state.sender,
                                                  //         receiver: state.receiver,
                                                  //       )
                                                      : (state is OnChatListScreenPage)
                                                          ? ChatListScreen()
                                                          : (state is OnSeeDoctorPage)
                                                              ? SeeDoctorPage(
                                                                  doctorUser: state.user)
                                                              : (state is OnHistoryPatientPage)
                                                                  ? HistoryPatientPage(
                                                                      call: state.call,
                                                                    )
                                                                  : (state is OnDoctorRatingPage)
                                                                      ? DoctorRatingPage(
                                                                          call: state.call,
                                                                        )
                                                                      : (state
                                                                              is OnPatientListMedicalRecordPage)
                                                                          ? PatientListMedicalRecordPage(
                                                                              user: state.user,
                                                                            )
                                                                          : (state
                                                                                  is OnBookAppointmentPage)
                                                                              ? BookingScreen(
                                                                                  doctor:
                                                                                      state.doctor,
                                                                                  patient:
                                                                                      state.patient,
                                                                                )
                                                                              : (state
                                                                                      is OnMyAppointments)
                                                                                  ? MyAppointments()
                                                                                  : MainPage(
                                                                                      bottomNavBarIndex:
                                                                                          (state as OnMainPage)
                                                                                              .bottomNavBarindex,
                                                                                    ),
    );
  }
}
