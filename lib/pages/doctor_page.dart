part of 'pages.dart';

class DoctorPage extends StatefulWidget {
  final m.DoctorType doctorType;
  DoctorPage(this.doctorType);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PickupLayout(
        scaffold: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(elevation: 0, backgroundColor: Colors.white, actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => VaccinePage()));
                },
                icon: Icon(Icons.notes, color: Colors.black)),
          ]),
          body: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(
                    defaultMargin, 20, defaultMargin, 30),
                // get user data from firebase using BlocUser
                child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                  if (userState is UserLoaded) {
                    // if (imageFileToUpload != null) {
                    //   uploadImage(imageFileToUpload).then((downloadUrl) {
                    //     imageFileToUpload = null;
                    //     context
                    //         .bloc<UserBloc>()
                    //         .add(UpdateUserData(profileImage: downloadUrl));
                    //   });
                    // }

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(GoToUserProfilePage());
                            // context.bloc<PageBloc>().add(GoDoctorSelectedPage());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: accentColor3, width: 1),
                            ),
                            child: Stack(
                              children: [
                                const SpinKitFadingCircle(
                                  color: accentColor2,
                                  size: 50,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: (userState.user!.profileImage !=
                                            "no_pic")
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                userState.user!.profileImage!),
                                            fit: BoxFit.cover)
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "images/user_default.png"),
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  78,
                              child: Text(
                                userState.user!.fullName!,
                                style: blackTextFont.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(userState.user!.job!),
                          ],
                        )
                      ],
                    );
                  } else {
                    return const SpinKitFadingCircle(
                      color: accentColor2,
                      size: 50,
                    );
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 140,
                  child: StreamBuilder(
                    stream: UserServices.getAllUser().asStream(),
                    builder: (context, AsyncSnapshot<List<m.User>> snapshot) {
                      List<m.User> userList = [];
                      String doctorStatus = "Doctor";
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        // userList = snapshot.data;
                        userList.clear();
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          if (snapshot.data![i].status == doctorStatus &&
                              snapshot.data![i].ratingNum! > 0.0) {
                            userList.add(snapshot.data![i]);
                          }
                        }
                        if (userList.isNotEmpty) {
                          return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, int index) {
                                return DoctorCard(
                                  doctorType: userList[index],
                                  onTap: () => context
                                      .read<PageBloc>()
                                      .add(GoToSeeDoctorPage(userList[index])),
                                );
                              },
                              separatorBuilder: (context, int index) =>
                                  const SizedBox(width: 16),
                              itemCount: userList.length);
                        } else {
                          return Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "...No doctor found for a moment...",
                                style: blackTextFont.copyWith(
                                    fontSize: 18, color: accentColor2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      LocalizationService.of(context).translate("top_rated")!,
                      style: blackTextFont.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                    TopRateDoctorListTile(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoodNewsListTile extends StatelessWidget {
  const GoodNewsListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      title: const Text("Is it safe to stay at home during corona virus ?"),
      subtitle: const Text("Today"),
      trailing: Container(
        height: 150,
        width: 50,
        child: Image.network(
          "http://www.pngmart.com/files/12/Coronavirus-Stay-Home-PNG-Clipart.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TopRateDoctorListTile extends StatefulWidget {
  @override
  _TopRateDoctorListTileState createState() => _TopRateDoctorListTileState();
}

class _TopRateDoctorListTileState extends State<TopRateDoctorListTile> {
  List<m.User> userList = [];
  @override
  Widget build(BuildContext context) {
    // int counter = 0;
    String doctorStatus = "Doctor";
    return StreamBuilder(
      stream: UserServices.getAllUser().asStream(),
      builder: (context, AsyncSnapshot<List<m.User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // userList = snapshot.data;
          userList.clear();
          for (int i = 0; i < snapshot.data!.length; i++) {
            if (snapshot.data![i].status == doctorStatus &&
                snapshot.data![i].ratingNum! > 3.0) {
              userList.add(snapshot.data![i]);
            }
          }
          if (userList.isNotEmpty) {
            return buildListDoctor(doctorStatus, context);
          } else {
            return Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "...${LocalizationService.of(context).translate("no_doctor")}...",
                  style:
                      blackTextFont.copyWith(fontSize: 18, color: accentColor2),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget buildListDoctor(String doctorStatus, context) {
    final List<m.User> doctorList = doctorStatus.isEmpty
        ? []
        : userList.where((m.User user) {
            String _doctorQuery = doctorStatus;
            String _getUserStatus = user.status!;
            double _rating = user.ratingNum!;
            bool matchStatus = _getUserStatus.contains(_doctorQuery);
            return (matchStatus && _rating > 3);
          }).toList();
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: doctorList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                m.User doctor = m.User(
                  doctorList[index].id,
                  doctorList[index].email,
                  fullName: doctorList[index].fullName,
                  job: doctorList[index].job,
                  profileImage: doctorList[index].profileImage,
                  ratingNum: doctorList[index].ratingNum,
                  alumnus: doctorList[index].alumnus,
                  noSIP: doctorList[index].noSIP,
                  state: doctorList[index].state,
                  status: doctorList[index].status,
                  tempatPraktek: doctorList[index].tempatPraktek,
                );
                return Container(
                  child: CustomChatTile(
                    mini: false,
                    leading: (doctor.profileImage!.isEmpty)
                        ? const CircularProgressIndicator()
                        : (doctor.profileImage != "no_pic")
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(doctor.profileImage!),
                              )
                            : const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage("images/user_default.png"),
                              ),
                    title: Text(
                      doctor.fullName!,
                      style: blackTextFont.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      doctor.job!,
                      style: greyTextFont,
                    ),
                    onTap: () {
                      context.read<PageBloc>().add(GoToSeeDoctorPage(doctor));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// userList = snapshot.data;
//             for (int i = 0; i < userList.length; i++) {
//               if (userList[i].status == doctorStatus &&
//                   userList[i].ratingNum > 3.0) {
//                 counter++;
//                 print(counter);
//               } else {
//                 counter--;
//               }
//             }
//             if (counter > 0) {
//               return buildListDoctor(doctorStatus);
//             } else {
//               return Container(
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "...No doctor found for a moment...",
//                     style: blackTextFont.copyWith(
//                         fontSize: 18, color: accentColor2),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               );
//             }

// ListTile(
//         //   contentPadding: EdgeInsets.symmetric(horizontal: 5),
//         //   leading: Image.network("${doctor.profileImage}"),
//         //   title: Text("${doctor.fullName}"),
//         //   subtitle: Text("${doctor.job}"),
// trailing: RatingBar(
//   allowHalfRating: true,
//   initialRating: doctor.ratingNum,
//   direction: Axis.horizontal,
//   itemCount: 5,
//   itemBuilder: (context, _) => Icon(
//     Icons.star,
//     color: Colors.amber,
//   ),
//   itemSize: 28,
//   onRatingUpdate: null,
// ),
//         // );

// return Container(
//                 height: 200,
//                 width: 400,
//                 padding: EdgeInsets.only(),
//                 child: ListView(
//                   children: [
//                     CustomChatTile(
//                         mini: false,
//                         leading: CircleAvatar(
//                           radius: 30,
//                           backgroundImage:
//                               NetworkImage(userList[i].profileImage),
//                         ),
//                         title: Text(
//                           userList[i].fullName,
//                           style: blackTextFont.copyWith(
//                               fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                         subtitle: Text(
//                           userList[i].job,
//                           style: greyTextFont,
//                         ),
//                         trailing: RatingBar(
//                           allowHalfRating: true,
//                           ignoreGestures: true,
//                           tapOnlyMode: true,
//                           initialRating: userList[i].ratingNum,
//                           direction: Axis.horizontal,
//                           itemCount: 5,
//                           itemBuilder: (context, _) => Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                           ),
//                           itemSize: 28,
//                           onRatingUpdate: null,
//                         ),
//                         onTap: () {}),
//                   ],
//                 ),
//               );

// return ListView.builder(
//         itemCount: doctorList.length,
//         itemBuilder: (context, index) {
//           User doctor = User(
//             doctorList[index].id,
//             doctorList[index].email,
//             fullName: doctorList[index].fullName,
//             status: doctorList[index].status,
//             profileImage: doctorList[index].profileImage,
//             ratingNum: doctorList[index].ratingNum,
//             job: doctorList[index].job,
//           );
//           return Container(
//             child: CustomChatTile(
//                 mini: false,
//                 leading: CircleAvatar(
//                   radius: 30,
//                   backgroundImage: NetworkImage(doctor.profileImage),
//                 ),
//                 title: Text(
//                   "dr.${doctor.fullName}",
//                   style: blackTextFont.copyWith(
//                       fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 subtitle: Text(
//                   doctor.job,
//                   style: greyTextFont,
//                 ),
//                 trailing: RatingBar.readOnly(
//                   maxRating: 5,
//                   isHalfAllowed: true,
//                   initialRating: doctor.ratingNum,
//                   halfFilledIcon: Icons.star_half,
//                   filledIcon: Icons.star,
//                   emptyIcon: Icons.star_border,
//                   size: 28,
//                   filledColor: Colors.yellow,
//                 ),
//                 onTap: () {}),
//           );
//         });
