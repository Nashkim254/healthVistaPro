part of 'pages.dart';

class MyAppointments extends StatefulWidget {
  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              LocalizationService.of(context).translate("my_appointments")!,
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Container(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          child: MyAppointmentList(),
        ),
      ),
    );
  }
}
