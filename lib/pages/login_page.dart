part of 'pages.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class LoginPage extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoggingIn = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() =>
              _supportState = isSupported ? _SupportState.supported : _SupportState.unsupported),
        );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
      if (authenticated == true) {
        SignInSignUpResult result = await AuthServices.signIn(
            email: SharedPrefs.getEmail(), password: SharedPrefs.getPassword());
      }
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () async {
        //when press back from login page, goto welcome page
        context.read<PageBloc>().add(GoToWelcomePage());
        return false;
      },
      child: Scaffold(
        backgroundColor: accentColor5.withOpacity(0.1),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset("images/logo.png"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 40),
                    child: Text(
                      "Login and start\nconsulting",
                      textAlign: TextAlign.center,
                      style: whiteTextFont.copyWith(fontSize: 28, color: Colors.white),
                    ),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: emailController,
                    style: const TextStyle(color: accentColor1),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Email address",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Email address",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: passwordController,
                    style: const TextStyle(color: accentColor1),
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        "Forgot password? ",
                        style: greyTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Get now! ",
                        style: pinkTextFont.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(top: 40, bottom: 30),
                      child: isLoggingIn
                          ? const SpinKitCircle(
                              color: accentColor2,
                            )
                          : FloatingActionButton(
                              backgroundColor:
                                  (isEmailValid && isPasswordValid) ? mainColor : accentColor3,
                              onPressed: (isEmailValid && isPasswordValid)
                                  ? () async {
                                      setState(() {
                                        isLoggingIn = true;
                                      });

                                      SignInSignUpResult result = await AuthServices.signIn(
                                          email: emailController.text,
                                          password: passwordController.text);
                                      SharedPrefs.setEmail(emailController.text);
                                      SharedPrefs.setPassword(passwordController.text);
                                      if (result.user == null) {
                                        setState(() {
                                          isLoggingIn = false;
                                        });
                                        Flushbar(
                                          duration: const Duration(seconds: 4),
                                          flushbarPosition: FlushbarPosition.TOP,
                                          backgroundColor: accentColor2,
                                          message: result.message,
                                        ).show(context);
                                      }
                                    }
                                  : null,
                              child: Icon(
                                Icons.arrow_forward,
                                color:
                                    (isEmailValid && isPasswordValid) ? Colors.white : Colors.grey,
                              )),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: _isAuthenticating
                        ? const SpinKitCircle(
                            color: accentColor2,
                          )
                        : SizedBox(
                            height: 100,
                            width: 200,
                            child: InkWell(
                                onTap: () async {
                                  if (_supportState == _SupportState.supported &&
                                      SharedPrefs.getEmail() != null) {
                                    await _authenticateWithBiometrics();
                                  }
                                },
                                child: Image.asset("images/fingerprint.png")),
                          ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Dont have an account ? ",
                        style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(GoToRegistrationPage());
                        },
                        child: Text(
                          "Sign up",
                          style: pinkTextFont,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
