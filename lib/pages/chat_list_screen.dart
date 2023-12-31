part of 'pages.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PickupLayout(
      scaffold: Scaffold(
          appBar: AppBar(
            title: Text(
              LocalizationService.of(context).translate("messages")!,
              style: blackTextFont.copyWith(
                fontSize: 28,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: ChatListScreenContainer()),
    ));
  }
}

class ChatListScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return StreamBuilder<QuerySnapshot>(
              stream: MessageServices.fetchContacts(userId: userState.user!.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var docList = snapshot.data!.docs;
                  if (docList.isEmpty) {
                    return QuietBox();
                  }
                  return ListView.builder(
                      itemCount: docList.length,
                      itemBuilder: (_, index) {
                       m.Contact contact = m.Contact.fromMap(docList[index].data() as Map<String, dynamic>);
                        return ContactView(contact);
                      });
                } else {
                  return Center(
                      child:
                          SpinKitFadingCircle(color: accentColor2, size: 100));
                }
              });
        } else {
          return Container();
        }
      },
    );
  }
}
