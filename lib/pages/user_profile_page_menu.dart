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
            title:  Text("Profile",style: blackTextFont.copyWith(fontSize: 20)),
            centerTitle: true,
          ),
          body: Container(
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
                          userProfileMenuTitle: "Edit Profile",
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
                            userProfileMenuTitle: "Sign Out",
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
                  ],
                )
              ],
            ),
          )),
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
