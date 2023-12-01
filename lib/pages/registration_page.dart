part of 'pages.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToWelcomePage());
        return true;
      },
      child: Scaffold(
        backgroundColor: accentColor5.withOpacity(0.1),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              // app bar
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 22),
                height: 56,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(GoToWelcomePage());
                        },
                        child: Icon(Icons.arrow_back_ios, size: 24, color: accentColor5),
                      ),
                    ),
                    Center(
                        child: Text(
                      "Create New\nAccount",
                      style: whiteTextFont.copyWith(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Container(
                  child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: mainColor,
                    ),
                    onPressed: () {
                      context
                          .read<PageBloc>()
                          .add(GoToRegistrationDoctorPage(m.RegistrationUserData()));
                    },
                    child: Text(
                      "Register As A Doctor",
                      style: whiteTextFont.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: accentColor2,
                    ),
                    onPressed: () {
                      context
                          .read<PageBloc>()
                          .add(GoToRegistrationUserPage(m.RegistrationUserData()));
                    },
                    child: Text(
                      "Register As A Patient",
                      style: blackTextFont.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
