part of 'pages.dart';

class ChatListPage extends StatefulWidget {
  final String? doctorSpeciality;

  ChatListPage(this.doctorSpeciality);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChatListContainer(doctorSpeciality: widget.doctorSpeciality!));
  }
}

class ChatListContainer extends StatefulWidget {
  final String? doctorSpeciality;

  ChatListContainer({this.doctorSpeciality});

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  List<m.User>? userList;
  m.User? sender;
  bool check = false;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    String queryDoctor = widget.doctorSpeciality!;
    return Container(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            userList = userState.userList;
            sender = userState.user!;
            // check user list if have the doctors
            for (int i = 0; i < userList!.length; i++) {
              if (userList![i].job == queryDoctor) {
                counter++;
              } else {
                counter += 0;
              }
            }

            if (counter > 0) {
              return buildSuggestion(queryDoctor, sender!);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocalizationService.of(context).translate("no_doctor")!,
                      style: blackTextFont.copyWith(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                        child: LottieBuilder.network(
                      "https://assets4.lottiefiles.com/packages/lf20_wdXBRc.json",
                      repeat: true,
                      fit: BoxFit.contain,
                    )),
                  ],
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget buildSuggestion(String? queryDoctor, m.User? sender) {
    final List<m.User> suggestionList = queryDoctor!.isEmpty
        ? []
        : userList!.where((m.User? user) {
            String _query = queryDoctor;
            String _getJob = user!.job!;
            bool matchJob = _getJob.contains(_query);
            return (matchJob);
          }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          m.User doctorType = m.User(
            suggestionList[index].id,
            suggestionList[index].email,
            fullName: suggestionList[index].fullName,
            job: suggestionList[index].job,
            profileImage: suggestionList[index].profileImage,
            alumnus: suggestionList[index].alumnus,
            noSIP: suggestionList[index].noSIP,
            status: suggestionList[index].status,
            tempatPraktek: suggestionList[index].tempatPraktek,
            state: suggestionList[index].state,
            ratingNum: suggestionList[index].ratingNum,
          );
          return Container(
            padding: EdgeInsets.only(
                top: defaultMargin, left: defaultMargin, right: defaultMargin),
            child: CustomChatTile(
                mini: false,
                leading:  (doctorType.profileImage != "no_pic")
                      ? CircleAvatar(
                  radius: 30,
                 backgroundImage:  NetworkImage(doctorType.profileImage!),
                ): CircleAvatar(
                  radius: 30,
                 backgroundImage:  AssetImage("images/user_default.png"),
                ),
                title: Text(
                  doctorType.fullName!,
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  doctorType.job!,
                  style: greyTextFont,
                ),
                trailing: Icon(
                  Icons.navigate_next,
                  size: 35,
                ),
                onTap: () {
                  context.read<PageBloc>().add(
                      GoToChatScreenPage(receiver: doctorType, sender: sender));
                }),
          );
        });
  }
}
