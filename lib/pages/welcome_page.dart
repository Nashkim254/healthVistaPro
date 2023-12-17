part of 'pages.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: const Image(
              image: AssetImage("images/afric.png"),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: accentColor1.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                  LocalizationService.of(context).translate("consultation")!,
                    style: whiteTextFont.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 38.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundedButton(
                      color: mainColor,
                      title: LocalizationService.of(context).translate("get_started"),
                      onPressed: () {
                        context.read<PageBloc>().add(GoToRegistrationPage());
                        // context.bloc<PageBloc>().add(
                        //     GoToRegistrationUserPage(RegistrationUserData()));
                      },
                    ),
                    RoundedButton(
                      color: accentColor2,
                      title: LocalizationService.of(context).translate("sign_in"),
                      onPressed: () {
                        context.read<PageBloc>().add(GoToLoginPage());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
