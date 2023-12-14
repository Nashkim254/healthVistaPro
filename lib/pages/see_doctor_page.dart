part of 'pages.dart';

class SeeDoctorPage extends StatefulWidget {
  final m.User? doctorUser;
  SeeDoctorPage({this.doctorUser});

  @override
  _SeeDoctorPageState createState() => _SeeDoctorPageState();
}

class _SeeDoctorPageState extends State<SeeDoctorPage> {
  String? profilePath;
  File? profileImageFile;

  @override
  void initState() {
    super.initState();
    profilePath = widget.doctorUser!.profileImage;
  }

  @override
  Widget build(BuildContext context) {
    // set Theme
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              context.read<PageBloc>().add(
                    GoToMainPage(bottomNavBarIndex: 0),
                  );
            },
          ),
          title: Text(
            "Profile",
            style: blackTextFont.copyWith(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Container(
          // padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 42, bottom: 20),
                    // height: 104,
                    // width: 90,
                    child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: profileImageFile != null
                                ? DecorationImage(
                                    image: FileImage(profileImageFile!), fit: BoxFit.cover)
                                : profilePath != ""
                                    ? DecorationImage(
                                        image: NetworkImage(profilePath!), fit: BoxFit.cover)
                                    : const DecorationImage(
                                        image: AssetImage("images/user_default.png"),
                                        fit: BoxFit.cover))),
                  ),
                  Text(
                    widget.doctorUser!.fullName!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.doctorUser!.job!,
                    style: greyTextFont.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alumnus",
                          style: greyTextFont,
                        ),
                        AbsorbPointer(
                          child: TextFormField(
                            style: blackTextFont.copyWith(fontWeight: FontWeight.w400),
                            initialValue: widget.doctorUser!.alumnus!,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Practice Location",
                          style: greyTextFont,
                        ),
                        AbsorbPointer(
                          child: TextFormField(
                            style: blackTextFont.copyWith(fontWeight: FontWeight.w400),
                            initialValue: widget.doctorUser!.tempatPraktek,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "No. SIP",
                          style: greyTextFont,
                        ),
                        AbsorbPointer(
                          child: TextFormField(
                            style: blackTextFont.copyWith(fontWeight: FontWeight.w400),
                            initialValue: widget.doctorUser!.noSIP,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        return SizedBox(
                          height: 45,
                          width: 250,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ), backgroundColor: mainColor,
                            ),
                            onPressed: () async {
                              context.read<PageBloc>().add(GoToChatScreenPage(
                                    receiver: widget.doctorUser,
                                    sender: userState.user,
                                  ));
                            },
                            child: Text(
                              "Start Consultation",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: accentColor7,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        return SizedBox(
                          height: 45,
                          width: 250,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ), backgroundColor: mainColor,
                            ),
                            onPressed: () async {
                              context.read<PageBloc>().add(GoToBookingAppointment(
                                    patient: userState.user!,
                                    doctor: widget.doctorUser!,
                                  ));
                            },
                            child: Text(
                              "Book Appointment",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: accentColor7,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
