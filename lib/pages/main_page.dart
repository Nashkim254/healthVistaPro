part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;

  MainPage({this.bottomNavBarIndex = 0});

  @override
  _MainPageState createState() => _MainPageState();
}

final UserServices userServices = UserServices();

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  // untuk mengatur navigation bar
  int? bottomNavbarIndex;
  // untuk mengatur pageview
  PageController? pageController;
  // PersistentTabController pageController;

  UserProvider? userProvider;

  @override
  void initState() {
    super.initState();
    bottomNavbarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavbarIndex!);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(this.context, listen: false);
      await userProvider!.refreshUser();

      UserServices.setUserState(userId: userProvider!.getUser.id!, userStates: UserStates.Online);
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _playText() {
    /// Provide text as string param
    AlanVoice.playText("Hello from Vista pro");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    String? currentUserId =
        (userProvider != null && userProvider?.getUser.id != null) ? userProvider!.getUser.id : "";

    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? UserServices.setUserState(userId: currentUserId, userStates: UserStates.Online)
            : print("resumed state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? UserServices.setUserState(userId: currentUserId, userStates: UserStates.Offline)
            : print("Inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? UserServices.setUserState(userId: currentUserId, userStates: UserStates.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? UserServices.setUserState(userId: currentUserId, userStates: UserStates.Offline)
            : print("Detached state");
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return PickupLayout(
      scaffold: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            if (userState.user!.status == "Patient") {
              // if user adalah pasien
              return Scaffold(
                backgroundColor: Colors.white,
                body: BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      // jika ada file profile gambar yang mau di upload dari page registrasi
                      if (imageFileToUpload != null) {
                        uploadImage(imageFileToUpload!).then((downloadUrl) {
                          imageFileToUpload = null;
                          context.read<UserBloc>().add(UpdateUserData(profileImage: downloadUrl));
                        });
                      }
                      return Stack(
                        children: [
                          Container(
                            color: mainColor,
                          ),
                          SafeArea(child: Container(color: mainColor)),
                          PageView(
                            controller: pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (index) {
                              setState(() {
                                bottomNavbarIndex = index;
                              });
                            },
                            children: [
                              DoctorPage(m.DoctorType()),
                              ChatListScreen(),
                              // HospitalPage(),
                              UserProfilePageMenu(),
                              MyAppointments(),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                bottomNavigationBar: BottomNavyBar(
                  showElevation: true,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  iconSize: 32,
                  selectedIndex: bottomNavbarIndex!,
                  onItemSelected: (index) {
                    setState(() => bottomNavbarIndex = index);
                    pageController!.jumpToPage(index);
                  },
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                        activeColor: mainColor,
                        inactiveColor: accentColor7,
                        icon: const Icon(
                          Icons.perm_contact_calendar,
                          // size: 28,
                          // color: accentColor2,
                        ),
                        title: Text(LocalizationService.of(context).translate("homepage")!)),
                    BottomNavyBarItem(
                        activeColor: mainColor,
                        inactiveColor: accentColor7,
                        icon: const Icon(
                          Icons.chat,
                          // size: 28,
                          // color: accentColor2,
                        ),
                        title: Text(LocalizationService.of(context).translate("messages")!)),
                    BottomNavyBarItem(
                        activeColor: mainColor,
                        inactiveColor: accentColor7,
                        icon: const Icon(
                          Icons.person_pin,
                          // size: 28,
                          // color: accentColor2,
                        ),
                        title: Text(LocalizationService.of(context).translate("profile")!)),
                    BottomNavyBarItem(
                        activeColor: mainColor,
                        inactiveColor: accentColor7,
                        icon: const Icon(
                          Icons.notes,
                          // size: 28,
                          // color: accentColor2,
                        ),
                        title: Text(LocalizationService.of(context).translate("appointments")!)),
                  ],
                ),
              );
            } else {
              // if user adalah dokter
              return PickupLayout(
                scaffold: Scaffold(
                  backgroundColor: Colors.white,
                  body: BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        // jika ada file profile gambar yang mau di upload dari page registrasi
                        if (imageFileToUpload != null) {
                          uploadImage(imageFileToUpload!).then((downloadUrl) {
                            imageFileToUpload = null;
                            context.read<UserBloc>().add(UpdateUserData(profileImage: downloadUrl));
                          });
                        }
                        return Stack(
                          children: [
                            Container(
                              color: mainColor,
                            ),
                            SafeArea(child: Container(color: mainColor)),
                            PageView(
                              controller: pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                setState(() {
                                  bottomNavbarIndex = index;
                                });
                              },
                              children: [
                                ChatListScreen(),
                                PatientListMedicalRecordPage(user: userState.user!),
                                UserProfilePageMenu(),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  bottomNavigationBar: BottomNavyBar(
                    showElevation: true,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    iconSize: 32,
                    selectedIndex: bottomNavbarIndex!,
                    onItemSelected: (index) {
                      setState(() => bottomNavbarIndex = index);
                      pageController!.jumpToPage(index);
                    },
                    items: <BottomNavyBarItem>[
                      // BottomNavyBarItem(
                      //     activeColor: mainColor,
                      //     inactiveColor: accentColor7,
                      //     icon: Icon(
                      //       Icons.perm_contact_calendar,
                      //       // size: 28,
                      //       // color: accentColor2,
                      //     ),
                      //     title: Text("Homepage")),
                      BottomNavyBarItem(
                        activeColor: mainColor,
                        inactiveColor: accentColor7,
                        icon: const Icon(
                          Icons.chat,
                          // size: 28,
                          // color: accentColor2,
                        ),
                        title: Text(LocalizationService.of(context).translate("messages")!),
                      ),
                      BottomNavyBarItem(
                        activeColor: mainColor,
                        inactiveColor: accentColor7,
                        icon: const Icon(
                          Icons.format_list_bulleted,
                          // size: 28,
                          // color: accentColor2,
                        ),
                        title:
                            Text(LocalizationService.of(context).translate("my_patient_record")!),
                      ),
                      BottomNavyBarItem(
                        activeColor: mainColor,
                        inactiveColor: accentColor7,
                        icon: const Icon(
                          Icons.person_pin,
                          // size: 28,
                          // color: accentColor2,
                        ),
                        title:
                            Text(LocalizationService.of(context).translate("my_patient_record")!),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      _playText();
                    },
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
