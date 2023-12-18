part of 'widgets.dart';

class QuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // to prevent back to this page when back button been pressed
      onWillPop: () => Future.value(false),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              if (userState is UserLoaded) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                  child: userState.user!.status == "Doctor"
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LocalizationService.of(context).translate("no_message_from_patient")!,
                              style: blackTextFont.copyWith(fontSize: 28),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LocalizationService.of(context).translate("no_message")!,
                              style: blackTextFont.copyWith(fontSize: 28),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary:
                                    mainColor, // Assuming `mainColor` is a predefined color variable
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(),
                                  ),
                                );
                              },
                              child: Text(
                                 LocalizationService.of(context).translate("no_message")!,
                                style: whiteTextFont.copyWith(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
