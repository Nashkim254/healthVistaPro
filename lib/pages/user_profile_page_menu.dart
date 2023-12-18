part of 'pages.dart';

class UserProfilePageMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set Theme
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());

        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            // leading: IconButton(
            //     icon: Icon(Icons.arrow_back),
            //     onPressed: () {
            //       context.bloc<PageBloc>().add(GoToMainPage());
            //     }),
            title: Text(LocalizationService.of(context).translate("profile")!,
                style: blackTextFont.copyWith(fontSize: 20)),
            centerTitle: true,
          ),
          body: Consumer<LocalizationController>(builder: (ctx, provider, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) {
                      // check user state loaded or not
                      if (userState is UserLoaded) {
                        m.User user = userState.user!;
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 74, bottom: 10),
                              width: 150,
                              height: 150,
                              child: Stack(
                                children: <Widget>[
                                  const Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: SpinKitFadingCircle(
                                        color: accentColor2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // width: 120,
                                    // height: 120,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: (user.profileImage != "no_pic")
                                            ? DecorationImage(
                                                image: NetworkImage(user.profileImage!),
                                                fit: BoxFit.cover)
                                            : const DecorationImage(
                                                image: AssetImage("images/user_default.png"),
                                                fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 130,
                                      child: OnlineDotIndicator(uid: userState.user!.id!))
                                ],
                              ),
                            ),
                            Text(
                              userState.user!.fullName!,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style:
                                  blackTextFont.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              userState.user!.job!,
                              style: greyTextFont.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  Column(
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) => UserProfileMenuListTile(
                            userProfileMenuTitle:
                                LocalizationService.of(context).translate("edit_profile")!,
                            onTap: () {
                              context
                                  .read<PageBloc>()
                                  .add(GoToEditProfilePage((userState as UserLoaded).user!));
                            },
                            leadingIcon: const Icon(
                              Icons.person,
                              color: accentColor2,
                            )),
                      ),
                      const DashDividerUserProfileMenu(),
                      BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                        if (userState is UserLoaded) {
                          return UserProfileMenuListTileMenu(
                              userProfileMenuTitle:
                                  LocalizationService.of(context).translate("sign_out")!,
                              onTap: () async {
                                await UserServices.setUserState(
                                    userId: userState.user!.id!, userStates: UserStates.Offline);
                                context.read<UserBloc>().add(UserSignOut());
                                AuthServices.signOut();
                                context.read<PageBloc>().add(GoToWelcomePage());
                              },
                              leadingIcon: const Icon(
                                Icons.exit_to_app,
                                color: accentColor2,
                              ));
                        } else {
                          return const SizedBox();
                        }
                      }),
                      const DashDivider(),
                      UserProfileMenuListTile(
                          userProfileMenuTitle:
                              LocalizationService.of(context).translate("reminders")!,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const ReminderHomePage()));
                          },
                          leadingIcon: const Icon(
                            Icons.exit_to_app,
                            color: accentColor2,
                          )),
                      const DashDivider(),
                      Text(
                        'Language',
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            SharedPrefs.setLocale("en");
                            LocalizationService.of(context).setLocale();
                           
                            provider.isEnglish = true;
                            provider.isArabic = false;
                             provider.toggleLanguage();
                          },
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: provider.isEnglish ? primaryColor : Color(0xffEAECF0),
                                width: provider.isEnglish ? 2 : 1,
                              ),
                              color: provider.isEnglish ? Color(0xffF3FFF8) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundImage: AssetImage('assets/flag1.png'),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'English',
                                      ),
                                    ]),
                                    Container(
                                      child: provider.isEnglish
                                          ? Padding(
                                              padding: const EdgeInsets.only(bottom: 0),
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('assets/nike.png'),
                                                        fit: BoxFit.cover)),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(bottom: 0),
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  child: Icon(Icons.circle_outlined,
                                                      size: 16, color: Color(0xffD0D5DD))),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            SharedPrefs.setLocale("ar");
                            LocalizationService.of(context).setLocale();

                            // _changeLanguage(Locale.fromSubtags(languageCode: 'sw'));
                            //
                            provider.isEnglish = false;
                            provider.isArabic = true;
                             provider.toggleLanguage();
                          },
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: provider.isArabic ? primaryColor : Color(0xffEAECF0),
                                width: provider.isArabic ? 2 : 1,
                              ),
                              color: provider.isArabic ? Color(0xffF3FFF8) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundImage: AssetImage('assets/flag2.png'),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Arabic',
                                      ),
                                    ]),
                                    Container(
                                      child: provider.isArabic
                                          ? Padding(
                                              padding: const EdgeInsets.only(bottom: 0),
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('assets/nike.png'),
                                                        fit: BoxFit.cover)),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(bottom: 0),
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  child: Icon(Icons.circle_outlined,
                                                      size: 16, color: Color(0xffD0D5DD))),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const DashDivider(),
                    ],
                  )
                ],
              ),
            );
          })),
    );
  }
}

class DashDividerUserProfileMenu extends StatelessWidget {
  const DashDividerUserProfileMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 16),
      child: generateDashedDivider(MediaQuery.of(context).size.width - 2 * defaultMargin),
    );
  }
}

class UserProfileMenuListTileMenu extends StatelessWidget {
  final String userProfileMenuTitle;
  final VoidCallback onTap;
  final Icon leadingIcon;

  UserProfileMenuListTileMenu(
      {required this.userProfileMenuTitle, required this.onTap, required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leadingIcon,
      title: Text(
        userProfileMenuTitle,
        style: blackTextFont.copyWith(fontSize: 16),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: accentColor2,
      ),
    );
  }
}

Widget generateDashedDividerUserMenu(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: const Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
