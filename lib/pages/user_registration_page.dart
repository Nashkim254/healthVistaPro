part of 'pages.dart';

class UserRegistrationPage extends StatefulWidget {
  // untuk menyimpan data registrasi
  final m.RegistrationUserData registrationUserData;

  UserRegistrationPage(this.registrationUserData);

  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.registrationUserData.fullName ?? "";
    emailController.text = widget.registrationUserData.email ?? "";
    jobController.text = widget.registrationUserData.job ?? "";
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
                          LocalizationService.of(context).translate("create_account")!,
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
                              image: widget.registrationUserData.profilePicture == null
                                  ? const DecorationImage(
                                      image: AssetImage("images/user_default.png"),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: FileImage(widget.registrationUserData.profilePicture!),
                                      fit: BoxFit.cover),
                            )),
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
                        labelText: LocalizationService.of(context).translate("full_name"),
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: LocalizationService.of(context).translate("full_name"),
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
                        labelText: LocalizationService.of(context).translate("email_address"),
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: LocalizationService.of(context).translate("email_address"),
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
                        labelText: LocalizationService.of(context).translate("current_job"),
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: LocalizationService.of(context).translate("current_job"),
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
                        labelText: LocalizationService.of(context).translate("password"),
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: LocalizationService.of(context).translate("password"),
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
                        labelText: LocalizationService.of(context).translate("confirm_password"),
                        labelStyle: const TextStyle(color: accentColor1),
                        hintText: LocalizationService.of(context).translate("confirm_password"),
                        hintStyle: const TextStyle(color: accentColor1)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                      backgroundColor: mainColor,
                      child: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        // jika semua field kosong
                        if ((fullNameController.text.trim() == "" &&
                            emailController.text.trim() == "" &&
                            passwordController.text.trim() == "" &&
                            retypeController.text.trim() == "")) {
                          Flushbar(
                            duration: const Duration(milliseconds: 5500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message: LocalizationService.of(context).translate("fill_fields"),
                          ).show(context);
                        } else if (!EmailValidator.validate(emailController.text)) {
                          Flushbar(
                            duration: const Duration(milliseconds: 4500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message:LocalizationService.of(context).translate("email_format"),
                          ).show(context);
                        } else if (passwordController.text != retypeController.text) {
                          Flushbar(
                            duration: const Duration(milliseconds: 4500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message: LocalizationService.of(context).translate("password_mismatch"),
                          ).show(context);
                        } else if (passwordController.text.length < 6) {
                          Flushbar(
                            duration: const Duration(
                              milliseconds: 4500,
                            ),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor2,
                            message: LocalizationService.of(context).translate("password_short"),
                          ).show(context);
                        } else {
                          // jika semua data validasi lolos
                          // isi registration data
                          // As a patient
                          widget.registrationUserData.fullName = fullNameController.text;
                          widget.registrationUserData.email = emailController.text;
                          widget.registrationUserData.job = jobController.text;
                          widget.registrationUserData.password = passwordController.text;
                          widget.registrationUserData.status = "Patient";
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
