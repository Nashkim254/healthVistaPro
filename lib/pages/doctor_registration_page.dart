part of 'pages.dart';

class DoctorRegistrationPage extends StatefulWidget {
  // untuk menyimpan data registrasi
  final m.RegistrationUserData registrationUserData;
  DoctorRegistrationPage(this.registrationUserData);

  @override
  _DoctorRegistrationPageState createState() => _DoctorRegistrationPageState();
}

class _DoctorRegistrationPageState extends State<DoctorRegistrationPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController noSipController = TextEditingController();
  TextEditingController alumnusController = TextEditingController();
  TextEditingController tempatPraktekController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.registrationUserData.fullName ?? "";
    emailController.text = widget.registrationUserData.email ?? "";
    jobController.text = widget.registrationUserData.job ?? "";
    noSipController.text = widget.registrationUserData.noSIP ?? "";
    alumnusController.text = widget.registrationUserData.alumnus ??"";
    tempatPraktekController.text = widget.registrationUserData.tempatPraktek ?? "";
  }

  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToRegistrationPage());
        return false;
      },
      child: Scaffold(
        backgroundColor: accentColor5.withOpacity(0.1),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  // app bar
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToWelcomePage());
                            },
                            child: const Icon(Icons.arrow_back_ios, size: 24, color: accentColor5),
                          ),
                        ),
                        Center(
                            child: Text(
                          "Create New\n Doctor Account",
                          style: whiteTextFont.copyWith(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                  Container(
                    height: 104,
                    width: 90,
                    child: Stack(
                      children: [
                        // container untuk background photo
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: (widget.registrationUserData.profilePicture) == null
                                ? const DecorationImage(
                                    image: AssetImage("images/user_default.png"), fit: BoxFit.cover)
                                : DecorationImage(
                                    image: FileImage(widget.registrationUserData.profilePicture!),
                                    fit: BoxFit.cover),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationUserData.profilePicture == null) {
                                widget.registrationUserData.profilePicture = await getImage();
                              } else {
                                widget.registrationUserData.profilePicture = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          (widget.registrationUserData.profilePicture == null
                                              ? "images/btn_add_photo.png"
                                              : "images/btn_delete_photo.png")))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  TextField(
                    style: const TextStyle(color: accentColor1),
                    controller: fullNameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Full Name",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Full Name",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    style: const TextStyle(color: accentColor1),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Email Address",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Email Address",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    style: const TextStyle(color: accentColor1),
                    controller: jobController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Your Speciality, ex : Physio",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Your Speciality, ex : Physio",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    style: const TextStyle(color: accentColor1),
                    controller: noSipController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Licence Number",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Licence Number",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    style: const TextStyle(color: accentColor1),
                    controller: alumnusController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Alumnus",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Alumnus",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    style: const TextStyle(color: accentColor1),
                    controller: tempatPraktekController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Practice Location",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Practice Location",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    obscureText: true,
                    style: const TextStyle(color: accentColor1),
                    controller: passwordController,
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
                    height: 16,
                  ),
                  TextField(
                    obscureText: true,
                    style: const TextStyle(color: accentColor1),
                    controller: retypeController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: accentColor5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: accentColor1)),
                        labelText: "Confirm Password",
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                      backgroundColor: mainColor,
                      child: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        // 
                        if ((fullNameController.text.trim() == "" &&
                            emailController.text.trim() == "" &&
                            jobController.text.trim() == "" &&
                            noSipController.text.trim() == "" &&
                            alumnusController.text.trim() == "" &&
                            tempatPraktekController.text.trim() == "" &&
                            passwordController.text.trim() == "" &&
                            retypeController.text.trim() == "")) {
                          Flushbar(
                            duration: const Duration(milliseconds: 5500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message: "Please fill all the text fields",
                          ).show(context);
                        } else if (!EmailValidator.validate(emailController.text)) {
                          Flushbar(
                            duration: const Duration(milliseconds: 4500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message: "Email format wrong, please check email format again",
                          ).show(context);
                        } else if (passwordController.text != retypeController.text) {
                          Flushbar(
                            duration: const Duration(milliseconds: 4500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message: "Mismatch password and confirm password",
                          ).show(context);
                        } else if (passwordController.text.length < 6) {
                          Flushbar(
                            duration: const Duration(
                              milliseconds: 4500,
                            ),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message:
                                "Password is too short, please input password more than 6 character",
                          ).show(context);
                        } else {
                          // jika semua data validasi lolos
                          // isi registration data
                          // As a doctor
                          widget.registrationUserData.fullName = fullNameController.text;
                          widget.registrationUserData.email = emailController.text;
                          widget.registrationUserData.job = jobController.text;
                          widget.registrationUserData.noSIP = noSipController.text;
                          widget.registrationUserData.alumnus = alumnusController.text;
                          widget.registrationUserData.tempatPraktek = tempatPraktekController.text;
                          widget.registrationUserData.password = passwordController.text;
                          widget.registrationUserData.status = "Doctor";
                          // GOTO Confirmation Page
                          context
                              .read<PageBloc>()
                              .add(GoToConfirmationPage(widget.registrationUserData));
                        }
                      }),
                  const SizedBox(
                    height: 30,
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
