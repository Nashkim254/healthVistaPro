part of 'widgets.dart';

class ContactView extends StatelessWidget {
  final m.Contact? contact;

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<m.User>(
      future: UserServices.getUser(contact!.id!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          m.User? user = snapshot.data;
          return ViewLayout(
            contact: user!,
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final m.User contact;
  ViewLayout({required this.contact});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          // TODO : sort new messages up
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: CustomChatTile(
              mini: false,
              onTap: () {
                context.read<PageBloc>().add(GoToChatScreenPage(
                    receiver: contact, sender: userState.user!));
              },
              leading: Container(
                constraints: const BoxConstraints(maxHeight: 60, maxWidth: 60),
                child: Stack(
                  children: [
                    CachedImage(
                      contact.profileImage!,
                      radius: 70,
                      isRounded: true,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 48,
                      child: OnlineDotIndicator(
                        uid: contact.id!,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                contact.fullName!,
                style: blackTextFont.copyWith(
                  fontSize: 19,
                ),
              ),
              subtitle: LastMessageContainer(
                stream: MessageServices.fetchLastMessageBetween(
                    senderId: userState.user!.id!, receiverId: contact.id!),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
