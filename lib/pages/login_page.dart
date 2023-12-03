part of 'pages.dart';

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

  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () async{
        //when press back from login page, goto welcome page
        context.read<PageBloc>().add(GoToWelcomePage());
        return true;
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
                    height: 30,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset("images/logo.png"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
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
                              child: Icon(
                                Icons.arrow_forward,
                                color:
                                    (isEmailValid && isPasswordValid) ? Colors.white : Colors.grey,
                              ),
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

                                      if (result.user == null) {
                                        setState(() {
                                          isLoggingIn = false;
                                        });

                                        // jika ada error
                                        Flushbar(
                                          duration: const Duration(seconds: 4),
                                          flushbarPosition: FlushbarPosition.TOP,
                                          backgroundColor: accentColor2,
                                          message: result.message,
                                        )..show(context);
                                      }
                                    }
                                  : null),
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
