part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final m.RegistrationUserData? registrationUserData;

  AccountConfirmationPage(this.registrationUserData);

  @override
  _AccountConfirmationPageState createState() => _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSignInUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        (widget.registrationUserData!.status == "Doctor")
            ? context.read<PageBloc>().add(GoToRegistrationDoctorPage(widget.registrationUserData!))
            : context.read<PageBloc>().add(GoToRegistrationUserPage(widget.registrationUserData!));
        return false;
      },
      child: Scaffold(
        backgroundColor: accentColor1.withOpacity(0.8),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 90),
                    height: 66,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              (widget.registrationUserData!.status == "Doctor")
                                  ? context
                                      .read<PageBloc>()
                                      .add(GoToRegistrationDoctorPage(widget.registrationUserData!))
                                  : context
                                      .read<PageBloc>()
                                      .add(GoToRegistrationUserPage(widget.registrationUserData!));
                            },
                            child: const Icon(Icons.arrow_back_ios, size: 24, color: Colors.white),
                          ),
                        ),
                        Center(
                            child: Text(
                          "Confirm New\nAccount",
                          style: whiteTextFont.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: widget.registrationUserData!.profilePicture != null
                          ? DecorationImage(
                              image: FileImage(widget.registrationUserData!.profilePicture!),
                              fit: BoxFit.cover)
                          : const DecorationImage(
                              image: AssetImage("images/user_default.png"), fit: BoxFit.cover),
                    ),
                  ),
                  Text(
                    "Welcome",
                    style: whiteTextFont.copyWith(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    (widget.registrationUserData!.status == "Doctor")
                        ? "Dr.${widget.registrationUserData!.fullName}"
                        : "${widget.registrationUserData!.fullName}",
                    style: whiteTextFont.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                  (isSignInUp)
                      ? const SpinKitCircle(
                          color: accentColor2,
                          size: 45,
                        )
                      : SizedBox(
                          height: 45,
                          width: 250,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                isSignInUp = true;
                              });

                              // gambar akan disimpan sementara, karena proses upload akan memakan waktu lama
                              imageFileToUpload = widget.registrationUserData!.profilePicture;

                              SignInSignUpResult result = await AuthServices.signUp(
                                emailAdress: widget.registrationUserData!.email,
                                fullName: widget.registrationUserData!.fullName,
                                job: widget.registrationUserData!.job,
                                password: widget.registrationUserData!.password,
                                noSIP: widget.registrationUserData!.noSIP,
                                status: widget.registrationUserData!.status,
                                alumnus: widget.registrationUserData!.alumnus,
                                tempatPraktek: widget.registrationUserData!.tempatPraktek,
                              );

                              // check authresult
                              if (result.user == null) {
                                setState(() {
                                  isSignInUp = false;
                                  // tampilkan pesan error
                                  Flushbar(
                                    duration: const Duration(milliseconds: 4500),
                                    backgroundColor: accentColor2,
                                    flushbarPosition: FlushbarPosition.TOP,
                                    message: result.message,
                                  ).show(context);
                                });
                              }else{
                                m.User user = result.user!;
                                UserProvider provider =
                                Provider.of<UserProvider>(context, listen: false);
                                context.read<UserBloc>().add(UserLoad(id: user.id));

                                prevPageEvent = GoToMainPage();
                                context.read<PageBloc>().add(prevPageEvent!);
                              }
                            },
                            child: Text(
                              "Create My Account",
                              style: whiteTextFont.copyWith(fontSize: 20),
                            ),
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
